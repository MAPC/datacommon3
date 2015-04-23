class DataSource < ActiveRecord::Base
  self.table_name = 'mbdc_datasource'
  self.primary_key = :id

  HTTP_REGEX = /https?:\/\//
  before_save :validate_http
  before_save :use_or_create_slug

  validates :title,       presence: true
  validates :description, presence: true
  validates :url,         presence: true

  lazy_load :description

  def self.default_scope
    order(:title)
  end

  def to_s
    title
  end

  has_and_belongs_to_many :visualizations,
    join_table:  :weave_visualization_datasources,
    foreign_key:             :datasource_id
    
  has_and_belongs_to_many :static_maps,
    join_table:  :mbdc_calendar_sources,
    foreign_key:             :datasource_id,
    association_foreign_key: :calendar_id

  private

    def validate_http
      self.url = "http://#{self.url}" unless HTTP_REGEX.match self.url
    end

    def use_or_create_slug
      self.slug ||= title.parameterize
    end

end
