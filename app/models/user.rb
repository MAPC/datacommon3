class User < ActiveRecord::Base

  self.table_name = 'auth_user'

  has_one  :profile
  has_many :visualizations, foreign_key: :owner_id

  def self.default_scope
    limit 10
  end

  def name
    if profile
      profile.name
    else
      "#{first_name} #{last_name}"
    end
  end

  def avatar_url
    ""
  end

  def to_s
    name.presence || username
  end

end
