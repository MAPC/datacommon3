class AddZipfileAttachmentToSpatialExtents < ActiveRecord::Migration
  def up
    add_attachment    :'metadata._geo_extents', :zipped_shapefile
  end

  def down
    remove_attachment :'metadata._geo_extents', :zipped_shapefile
  end
end


