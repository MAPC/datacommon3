# namespace :meta do
#   desc "Read _public_tables and create layers from scratch"
#   task :import => :environment do

#     def execute_sql(q)
#       ActiveRecord::Base.connection.execute q
#     end

   
#     tables = execute_sql "SELECT name FROM metadata._public_tables"
    
#     tables.each_row do |table|
  
#       # table = "b01002_med_age_acs_m"
#       meta_fields = execute_sql "SELECT * FROM metadata.#{table.first} ORDER BY orderid"
#       meta_fields = meta_fields.collect {|f| f}

#       Layer.create(
#         join_key:   meta_fields[0]['details'],
#         title:      meta_fields[1]['details'],
#         alt_title:  meta_fields[2]['details'],
#         descriptn:  meta_fields[3]['details'],
#         subject:    meta_fields[4]['details'],
#         creator:    meta_fields[5]['details'],
#         createdate: meta_fields[6]['details'],
#         moddate:    meta_fields[7]['details'],
#         datesavail: meta_fields[8]['details'],
#         publisher:  meta_fields[9]['details'],
#         contributr: meta_fields[10]['details'],
#         coverage:   meta_fields[11]['details'],
#         universe:   meta_fields[12]['details'],
#         schema:     meta_fields[13]['details'],
#         tablename:  meta_fields[14]['details'],
#         tablenum:   meta_fields[15]['details'],
#         institution_id: 1)


#     end

#   end
# end