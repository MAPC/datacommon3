# #snapshots returns an array of one DynamicVisualization
# for each topic in IssueArea.all
class SnapshotFacade

  attr_accessor :geography, :topics, :visualizations

  def initialize(geography)
    @geography      = geography
    @topics         = IssueArea.all
    @visualizations = get_visualizations
  end


  def get_visualizations
    @topics.map do |topic|
      vis = topic.dynamic_visualizations.where(
        regiontype_id: @geography.regiontype_id
      ).limit(1).first

      # Return a NullVisualization if there are
      # not yet visualizations for a topic.
      vis ||= NullVisualization.new

      OpenStruct.new(
        path:  "#{@geography.slug}/#{topic.slug}",
        title: topic.title,
        vis:   vis )
    end
  end

  
  def area_type_name
    @geography.class.name.downcase
  end

  
  def geography_slug
    @geography.slug
  end

  
  def options_for_area
    @geography.class.all.map {|g| [g.name, g.slug]}
  end

  
  def map_geojson
    @geography.to_geojson
  end
end