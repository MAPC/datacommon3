class User < ActiveRecord::Base

  self.establish_connection :datacommon
  self.table_name = 'maps_contact'

  has_many :visualizations, foreign_key: :owner_id

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    ""
  end

  def to_s
    name
  end

  default_scope { limit 10 }
end
