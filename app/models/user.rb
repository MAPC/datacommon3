class User < ActiveRecord::Base

  self.establish_connection :datacommon
  self.table_name = 'auth_user'

  has_many :visualizations, foreign_key: :owner_id

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    full_name.presence || username
  end

  default_scope { limit 10 }
end
