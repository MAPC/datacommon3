class Visualization < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'weave_visualization'

  belongs_to :user, foreign_key: :owner_id
  
  has_and_belongs_to_many :data_sources,
    join_table: :weave_visualization_datasources,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many :issue_areas,
    join_table: :weave_visualization_topics,
    association_foreign_key: :topic_id

  # We don't always need this -- only when showing --
  # so this removes the column from the default_scope.
  # Call Visualization.count(:all) to get
  # the unscoped record count.
  lazy_load :sessionstate

  paginates_per      8
  max_paginates_per 16

  
  def self.showing # for use when showing details
    self.includes(:issue_areas)
  end


  def self.recent(count=4)
    self.order('last_modified DESC').limit(count)
  end


  def self.random
    Visualization.offset(rand(Visualization.count(:all))).first
  end

  def owner_display_name
    owner.display_name
  end


  def base_image_path
    "http://metrobostondatacommon.org/site_media/weave_thumbnails/#{id}"
  end


  def gallery_image_path
    "#{base_image_path}_gallery.png"
  end


  def preview_image_path
    "#{base_image_path}_featured.png"
  end

  alias_method :owner, :user
end
