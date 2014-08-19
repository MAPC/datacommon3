class User < ActiveRecord::Base

  self.establish_connection :datacommon
  self.table_name = 'auth_user'

  has_many :visualizations, foreign_key: :owner_id

  default_scope { limit 10 }
end
