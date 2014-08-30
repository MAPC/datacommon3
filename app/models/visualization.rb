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


  scope :topic,       -> t { joins(:issue_areas).where( "mbdc_topic.slug = ?",    t) }
  scope :data_source, -> d { joins(:data_sources).where("mbdc_datasource.id = ?", d) }


  def self.featured
    self.find_by_sql """SELECT weave_visualization.*
                        FROM weave_visualization
                        INNER JOIN mbdc_featured
                          ON mbdc_featured.visualization_id = weave_visualization.id
                        ORDER BY mbdc_featured.visualization_id ASC"""
    end

  
  def self.random
    self.offset(rand(self.count(:all))).first
  end


  def self.showing # for use when showing details
    self.includes(:issue_areas)
  end


  def self.recent(count=4)
    self.order('last_modified DESC').limit(count)
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


  def to_s
    title
  end

  alias_method :owner, :user


  private

    def self.issue_area_for(issue_area_or_slug)
      case issue_area_or_slug
      when String then IssueArea.find_by(slug: issue_area_or_slug)
      else
        issue_area_or_slug
      end
    end

end
