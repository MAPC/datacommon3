class SpatialExtent < ActiveRecord::Base

  self.table_name = 'metadata._geo_extents'

  has_and_belongs_to_many :layers,
  join_table: 'metadata._geo_extents_geo_layers',
  foreign_key:             :geo_extent_id,
  association_foreign_key: :geo_layer_id

  def self.default_scope
    order(:title)
  end

  def to_s
    title
  end

end
