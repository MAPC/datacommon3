class User < ActiveRecord::Base
  self.table_name  = 'auth_user'
  self.primary_key = :id
  attr_accessor :remember_token, :password

  before_save   :downcase_email
  before_save   :encrypt_password, if: Proc.new { |user| user.password? }

  before_create :create_activation_digest

  after_create  :create_default_profile
  after_create  :send_new_account_followup_email

  has_one  :profile
  has_many :visualizations, foreign_key: :owner_id
  belongs_to :institution

  validates :username,   presence: true,
              length:     { minimum: 5, maximum: 30 },
              uniqueness: { case_sensitive: false, message: "Someone else has already taken that username." }
  validate :valid_username
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  validates :email,      presence: true, length: { minimum: 5, maximum: 75 }, uniqueness: { case_sensitive: false }
  validate  :valid_email

  validates :password,   presence: true, length: { minimum: 5, maximum: 128 }
  validates_confirmation_of :password

  # Not tested
  def own_visualizations
    Visualization.unscoped.where(owner: self).order('updated_at DESC')
  end

  def name
    if profile && profile.name.presence
      profile.name
    else
      full_name_or_username
    end
  end

  def email_host
    base_host = Rails.configuration.action_mailer.default_url_options[:host]
    return base_host if Rails.env == 'development'
    institution.presence ? institution.domain : "metroboston.#{base_host}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def fname
    f = profile && profile.name ? profile.name : full_name_or_username
    f.split(' ').first.capitalize
  end

  def avatar_url(size=75)
    gravatar_id = Digest::MD5.hexdigest(email)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def activate!
    update_attribute(:activation_token, nil)
    update_attribute(:is_active,        true)
    update_attribute(:activated_at,     Time.zone.now)
  end

  def active?
    activated_at.present?
  end

  def inactive?
    !active?
  end

  def activated?
    active?
  end

  def staff?
    is_staff
  end

  def admin?
    is_superuser
  end


  def to_s
    name
  end

  def to_param
    username
  end


  # def self.default_scope
  #   limit 10
  # end


  def password?
    password
  end


  def authenticate(password)
    # Password stored in db as {algorithm}${salt}${hash}
    _, salt, hash = password_digest.split '$'

    if hash == Digest::SHA1.hexdigest(salt + password)
      self.update_attribute :last_login, Time.now
      self
    else
      nil
    end
  end


  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    Digest::SHA1.hexdigest(token) == digest
  end


  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end


  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def reset_password!
    create_reset_digest
    send_password_reset_email
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def create_default_profile
    unless self.profile
      self.create_profile(
        name:  self.full_name,
        email: self.email,
        website_url: ""
      )
    end
  end

  def send_new_account_followup_email
    send_activation_email
  end



  rails_admin do
    list do
      field :username
      field :first_name
      field :last_name
      field :email
      field :is_active
      field :is_staff
      field :is_superuser
      field :date_joined
    end
    edit do
      field :username
      field :first_name
      field :last_name
      field :email
      field :password
      field :password_confirmation
      field :is_staff
      field :is_active
      field :is_superuser
      field :last_login do
        read_only true
      end
      field :date_joined do
        read_only true
      end
      field :activated_at do
        read_only true
      end
      field :reset_sent_at do
        read_only true
      end
      field :institution
    end
  end

  def resend_activation_email
    return false if active?
    return true  if send_activation_email
  end

  private

    def full_name_or_username
      full_name.presence || username
    end

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      activation_token       = User.new_token
      self.activation_token  = activation_token
      self.activation_digest = User.digest(activation_token)
    end

    def create_reset_digest
      reset_token = User.new_token
      update_attribute(:reset_token,   reset_token)
      update_attribute(:reset_digest,  User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_activation_email
      UserMailer.account_activation(self.id).deliver
    end

    def send_password_reset_email
      UserMailer.password_reset(self.id).deliver
    end

    # def create_remember_token
    #   self.remember_token = User.digest(User.new_token)
    # end

    def encrypt_password
      salt = Digest::SHA1.hexdigest(username)[0..4]
      hash = Digest::SHA1.hexdigest(salt + password)
      self.password_digest = "sha1$#{salt}$#{hash}"
    end

    # def set_timestamps
    #   date_joined = last_login = Time.now
    # end

    # def set_default_permissions
    #   is_active    = true
    #   is_staff     = false
    #   is_superuser = false
    # end

    def valid_email
      addr = Mail::Address.new(email)
      throw StandardError if [addr.local, addr.domain].include?(nil)
    rescue
      errors.add(:email, "must be a valid email address")
    end

    def valid_username
      # Must match only word characters
      if !username.to_s.match /^[\w]*$/
        errors.add(:username, "can only contain letters, numbers, and underscores")
      end
    end

end
