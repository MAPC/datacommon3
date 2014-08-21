class IssueArea < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'mbdc_topic'

  has_and_belongs_to_many :visualizations,
    join_table:  :weave_visualization_topics,
    foreign_key: :topic_id

  def sort_order
    self.send(:order)
  end
end
