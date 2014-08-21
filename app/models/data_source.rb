class DataSource < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = :mbdc_datasource

  lazy_load :description

  has_and_belongs_to_many :visualizations,
    join_table:  :weave_visualization_datasources,
    foreign_key:             :datasource_id
    
  has_and_belongs_to_many :static_maps,
    join_table:  :mbdc_calendar_sources,
    foreign_key:             :datasource_id,
    association_foreign_key: :calendar_id
end
