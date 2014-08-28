class DynamicVisualization < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'snapshots_visualization'

  has_and_belongs_to_many :issue_areas,
    join_table: :weave_visualization_topics,
    association_foreign_key: :topic_id

  # TODO: There's a more concise way to alias the
  #       sessionstate column than the below. It's 
  #       probably in the Metaprogramming book.

  def sessionstate
    vis_path  = read_attribute(:sessionstate).partition('/').last
    file_path = "#{Rails.root}/public/dynamic_#{vis_path}"
    File.open(File.expand_path file_path).read
  end

  def sessionstate_path
    read_attribute(:sessionstate)
  end

end
