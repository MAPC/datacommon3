class GeometryModel < ActiveRecord::Base
  self.abstract_class = true

  self.establish_connection :datacommon
  self.table_name = 'snapshots_regionalunit'

  lazy_load :geometry


  def centroid
    get_query_json """SELECT ST_AsGeoJSON(
                        ST_Transform(ST_Centroid(geometry), 4326))
                      FROM snapshots_regionalunit WHERE unitid = '#{unitid}'"""
  end


  def to_geojson
    get_query_json """SELECT ST_AsGeoJSON(ST_Transform(geometry, 4326))
                      FROM snapshots_regionalunit WHERE unitid = '#{unitid}'"""
  end


  private


  def get_query_json(q)
    result = ActiveRecord::Base.connection.execute(q)
    result.first.to_json
  end

end
