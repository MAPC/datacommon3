class DataSource < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = :mbdc_datasource

  lazy_load :description
end
