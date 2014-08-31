class TopicSnapshot

  attr_accessor :geography, :topic, :visualizations

  def initialize(geography, visualizations, topic)
    @geography, @visualizations, @topic = geography, visualizations, topic
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