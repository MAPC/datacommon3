class GeometryModel < ActiveRecord::Base
  self.abstract_class = true

  if Rails.env == "production"
    self.establish_connection :datacommon
    self.table_name = 'snapshots_regionalunit'
  end

  lazy_load :geometry,
            :short_desc,
            :short_desc_markup_type,
            :_short_desc_rendered


  def centroid
    get_query_json """SELECT ST_AsGeoJSON(
                        ST_Transform(ST_Centroid(geometry), 4326))
                      FROM snapshots_regionalunit WHERE unitid = '#{unitid}'"""
  end


  def to_geojson
    get_query_json """SELECT ST_AsGeoJSON(ST_Transform(ST_SetSRID(geometry, 26986), 4326))
                      FROM snapshots_regionalunit WHERE unitid = '#{unitid}'"""
  end


  def to_param
    slug
  end


  def to_s
    name
  end


  private


  def get_query_json(q)
    result = ActiveRecord::Base.connection.execute(q)
    result.first["st_asgeojson"].to_json
  end

end
