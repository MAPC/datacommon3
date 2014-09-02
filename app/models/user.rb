class User < ActiveRecord::Base

  self.table_name = 'auth_user'

  has_one  :profile
  has_many :visualizations, foreign_key: :owner_id

  def self.default_scope
    limit 10
  end

  def name
    if profile
      profile.name.titleize
    else
      full_name_or_username
    end
  end

  def avatar_url
    ""
  end

  def to_s
    name
  end

  private

  def full_name_or_username
    "#{first_name} #{last_name}".titleize.presence || username
  end


end
