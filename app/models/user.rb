class User < ActiveRecord::Base
  self.table_name = 'auth_user'
  attr_accessor :remember_token, :activation_token, :reset_token, :password

  before_save :downcase_email
  before_save :encrypt_password, if: Proc.new { |user| user.password? }
  before_create :create_activation_digest
  
  # before_save :set_timestamps,   if: Proc.new { |user| user.new_record?       }
  # before_save :set_default_permissions, if: Proc.new { |user| user.new_record? }

  has_one  :profile
  has_many :visualizations, foreign_key: :owner_id

  validates :username,   presence: true, length: { minimum: 5, maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  validates :email,      presence: true, length: { minimum: 5, maximum: 75 }, uniqueness: { case_sensitive: false }
  validate  :valid_email

  validates :password,   presence: true, length: { minimum: 5, maximum: 128 }
  validates_confirmation_of :password
  
  def name
    profile ? profile.name.titleize : full_name_or_username
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
    update_attribute(:is_active,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def activated?
    is_active
  end


  def to_s
    name
  end


  def to_param
    username
  end


  def self.default_scope
    limit 10
  end


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

  def new_account_followup_emails
    send_activation_email
  end


  private

    def full_name_or_username
      "#{first_name} #{last_name}".titleize.presence || username
    end

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def create_reset_digest
      self.reset_token  = User.new_token
      update_attribute(:reset_digest,  User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_activation_email
      UserMailer.account_activation(self).deliver
    end

    def send_password_reset_email
      UserMailer.password_reset(self).deliver
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
      begin
        addr = Mail::Address.new(email)
        throw StandardError if [addr.local, addr.domain].include?(nil)
      rescue
        errors.add(:email, "must be a valid email address")
      end
    end

end
