class StaticMap < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = :mbdc_calendar

  has_and_belongs_to_many :data_sources,
    join_table: :mbdc_calendar_sources,
    foreign_key:             :calendar_id,
    association_foreign_key: :datasource_id
end
