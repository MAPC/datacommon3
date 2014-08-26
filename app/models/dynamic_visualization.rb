class DynamicVisualization < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'snapshots_visualization'

  has_and_belongs_to_many :issue_areas,
    join_table: :weave_visualization_topics,
    association_foreign_key: :topic_id

end
