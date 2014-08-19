class Visualization < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'weave_visualization'

  belongs_to :user, foreign_key: :owner_id

  default_scope { limit 10 }
end
