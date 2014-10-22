class Layer < ActiveRecord::Base
  belongs_to :institution

  JOINABLE_ROW_LIMIT = 400

  def self.default_scope
    order(:title)
  end

  include InstitutionScope

  def description
    read_attribute(:descriptn).to_s
  end

  def image
    preview_image || "/layers/no-layer-preview.png"
  end

  alias_method :desc, :description

  paginates_per 8


  def to_param
    tablename
  end


  def to_s
    title || alt_title
  end


  def to_csv
    hash = JSON.parse self.to_json
    header = hash.collect { |field| field.first }.join(',')
    values = hash.collect { |field| field.last  }.join(',')
    [header, values].join("\n")
  end

  # This should be restructured when we move from just Layer to
  # SpatialLayer and AttributeLayer.
  # TODO: Replace ma_municipal with metadata field.
  # TODO: Move this to a background job, as a backlog item.

  # def layer_to_json
  #   begin
  #     joined_layer_to_json
  #   rescue
  #     spatial_layer_to_json
  #   end
  # end

  # def spatial_layer_to_json
  #   query = <<-EOQ
  #     SELECT
  #       ST_AsEWKT(ST_Transform(gisdata.ma_municipal.the_geom, 4326))
  #       AS geom
  #     FROM gisdata.ma_municipal
  #   EOQ

  #   results = ActiveRecord::Base.connection.execute query
  #   results.to_json
  # end


  # def joined_layer_to_json
  #   assert_fewer_than_400_rows

  #   query = <<-EOQ
  #     SELECT
  #       mapc.#{tablename}.*,
  #       ST_AsEWKT(ST_Transform(gisdata.#{spatialtbl}.the_geom, 4326))
  #     FROM mapc.#{tablename}
  #     INNER JOIN gisdata.#{spatialtbl}
  #       ON mapc.#{tablename}.muni_id = gisdata.#{spatialtbl}.muni_id;
  #   EOQ

  #   results = ActiveRecord::Base.connection.execute query
  #   results.to_json
  # end


  # SPATIAL_TABLES = {
  #   "municipal"     => "ma_municipal",
  #   "block groups"  => "ma_municipal",        # TODO change to blockgroups layer
  #   "census tracts" => "ma_census2010_tracts"
  # }

  def spatialtbl
    spatial = title.match(/\((.*)\)/).captures.first.downcase
    SPATIAL_TABLES[spatial]
  end

  private

  def assert_fewer_than_400_rows
    rows  = ActiveRecord::Base.connection.execute "SELECT COUNT(*) FROM gisdata.#{spatialtbl}"
    count = rows.first['count'].to_i
    
    if count > JOINABLE_ROW_LIMIT
      raise SpatialTableTooLargeError, """
        In order to join tabular data to a spatial table dynamically,
        the spatial table must be fewer than 500 rows. Table
        `gisdata.#{spatialtbl}` is #{count} rows.
      """
    end
  end


end

