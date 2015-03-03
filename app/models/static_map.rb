class StaticMap < ActiveRecord::Base
  self.table_name = 'mbdc_calendar'

  has_and_belongs_to_many :data_sources,
    join_table: :mbdc_calendar_sources,
    foreign_key:             :calendar_id,
    association_foreign_key: :datasource_id

  has_and_belongs_to_many :issue_areas,
    join_table: :mbdc_calendar_topics,
    foreign_key:             :calendar_id,
    association_foreign_key: :topic_id

  has_attached_file :map, styles: { thumbnail: ['500x375>', :png] }
  
  belongs_to :institution
  
  validates :title,    presence: true
  validates :abstract, presence: true
  validates :month,    presence: true
  validates :year,     presence: true
  validates :map_file_name, presence: true
  validates_attachment_content_type :map, :content_type => /\Aapplication\/pdf\Z/

  # include InstitutionScope
  include DataResourceFilters

  def self.default_scope
    order('id DESC')
  end

  def to_s
    title
  end

  alias_method :topics, :issue_areas

  paginates_per 9
  
  def date
    Date.new(year, month).to_s(:monthyear)
  end
end
