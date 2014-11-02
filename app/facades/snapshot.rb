# #snapshots returns an array of one DynamicVisualization
# for each topic in IssueArea.all
class Snapshot

  attr_accessor :geography, :topics, :visualizations

  def initialize(geography, topics, institution)
    @geography, @topics, @institution = geography, topics, institution
  end

  
  def area_type_name
    @geography.class.name.downcase
  end


  def area_type_id
    "#{area_type_name.pluralize}_id"
  end

  
  def geography_slug
    @geography.slug
  end

  
  def options_for_area
    @geography.class.only_inst(@institution).map {|g| [g.name, g.slug]}
  end

  
  def map_geojson
    @geography.to_geojson
  end
end