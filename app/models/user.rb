class User < ActiveRecord::Base
  self.table_name = 'auth_user'

  before_create :create_remember_token
  
  # to be consistent with legacy database
  before_save :encrypt_password, if: Proc.new { |user| user.password_changed? }
  # before_save :set_timestamps,   if: Proc.new { |user| user.new_record?       }
  # before_save :set_default_permissions, if: Proc.new { |user| user.new_record? }


  has_one  :profile
  has_many :visualizations, foreign_key: :owner_id


  validates :username,   presence: true, length: { minimum: 5, maximum: 30 }, uniqueness: true
  # validates :first_name, presence: true, length: { maximum: 30 }
  # validates :last_name,  presence: true, length: { maximum: 30 }

  validates :email,      presence: true, length: { minimum: 5, maximum: 75 }, uniqueness: true
  validate  :valid_email

  # validates :password,   presence: true, length: { minimum: 5, maximum: 128 }
  # validates_confirmation_of :password
  
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


  def to_s
    name
  end


  def to_param
    username
  end


  def self.default_scope
    limit 10
  end


  def self.authenticate(username, password)
    user = find_by(username: username)
    return nil if user.nil?
    
    # Password stored in db as {algorithm}${salt}${hash}
    _, salt, hash = user.password.split '$'

    if user && hash == Digest::SHA1.hexdigest(salt + password)
      user.update_attribute :last_login, Time.now
      user
    else
      nil
    end
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end


  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

    def full_name_or_username
      "#{first_name} #{last_name}".titleize.presence || username
    end

    
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

    def encrypt_password
      self.password = password_digest
    end


    def password_digest
      salt = Digest::SHA1.hexdigest(username)[0..4]
      hash = Digest::SHA1.hexdigest(salt + password)
      "sha1$#{salt}$#{hash}"
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
