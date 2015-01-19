ActiveRecord::Base.establish_connection :geographic

class AddZipfileAttachmentToSpatialExtents < ActiveRecord::Migration
  def up
    add_attachment    :'_geo_extents', :zipped_shapefile
    # add_version_to_db
  end

  def down
    remove_attachment :'_geo_extents', :zipped_shapefile
    # remove_version_from_db
  end
  
  # def add_version_to_db(connection_name=nil)
  #   conn = connection_name || Rails.env
  #   update_version_in_db conn, "INSERT INTO public.schema_migrations VALUES ('#{version}')"
  # end

  # def remove_version_from_db(connection_name=nil)
  #   conn = connection_name || Rails.env
  #   update_version_in_db conn, "DELETE FROM public.schema_migrations WHERE version = '#{version}'"
  # end

  # def update_version_in_db(connection_name, query)
  #   version = __FILE__.partition('_').first
  #   ActiveRecord::Base.establish_connection connection_name
  #   ActiveRecord::Base.connection.execute query
  # end
end


