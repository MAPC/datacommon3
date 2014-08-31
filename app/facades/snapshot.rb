# #snapshots returns an array of one DynamicVisualization
# for each topic in IssueArea.all
class Snapshot

  attr_accessor :geography, :topics, :visualizations

  def initialize(geography, topics)
    @geography, @topics = geography, topics
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