class SpatialExtent < ActiveRecord::Base

  # self.establish_connection :geographic if Rails.env == 'production'
  self.table_name = '_geo_extents'

  has_and_belongs_to_many :layers,
    join_table: '_geo_extents_geo_layers',
    foreign_key:             :geo_extent_id,
    association_foreign_key: :geo_layer_id

  has_attached_file :zipped_shapefile, path: "/:class/:attachment/:filename"
  validates_attachment_content_type :zipped_shapefile, content_type: /\Aapplication\/zip\Z/

  def self.default_scope
    order(:title)
  end

  def to_s
    title
  end

  alias_attribute :description, :desc

end
