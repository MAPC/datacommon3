class User < ActiveRecord::Base
  self.table_name = 'auth_user'

  before_create :create_remember_token

  has_one  :profile
  has_many :visualizations, foreign_key: :owner_id

  
  def name
    profile ? profile.name.titleize : full_name_or_username
  end

  def fname
    f = profile && profile.name ? profile.name : full_name_or_username
    f.split(' ').first.capitalize
  end

  def avatar_url ; "" ; end


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


end
