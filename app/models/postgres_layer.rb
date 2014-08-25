class PostgresLayer < ActiveRecord::Base
  self.establish_connection :layers
  self.table_name = 'information_schema.tables'
  self.primary_key = :table_name

  # Eventually, table_schema will be 'meta'.
  self.default_scope { where("table_catalog = 'weave'")
                        .where("table_schema = 'public'") }
end
