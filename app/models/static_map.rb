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

  
  belongs_to :institution
  
  include InstitutionScope

  def self.default_scope
    order('id DESC')
  end


  paginates_per 8


  def date
    date = Date.new(year, month)
    date.stamp("May 2014")
  end


  def thumbnail_src
    "http://metrobostondatacommon.org/site_media/#{thumbnail}"
  end


  def pdf_page_src
    "http://metrobostondatacommon.org/site_media/#{pdf_page}"
  end
end
