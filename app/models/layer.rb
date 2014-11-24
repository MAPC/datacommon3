class Layer < ActiveRecord::Base
  belongs_to :institution

  self.table_name = 'metadata._geo_layers'

  has_and_belongs_to_many :spatial_extents,
    join_table: 'metadata._geo_extents_geo_layers',
    foreign_key:             :geo_layer_id,
    association_foreign_key: :geo_extent_id

  # TODO: This is unused at the moment.
  # has_attached_file :csv
  # validates_attachment_content_type :csv, content_type: /\A.*\/csv\Z/

  def csv_for(object)
    file = File.open "#{Rails.public_path}/system/"
  end

  def self.default_scope
    order(:title)
  end

  include InstitutionScope

  def description
    read_attribute(:descriptn).to_s
  end

  alias_method :desc, :description

  paginates_per 8

  def to_param
    tablename
  end

  alias_attribute :dates,   :datesavail
  alias_attribute :created, :createdate

  def to_s
    title || alt_title
  end

end

