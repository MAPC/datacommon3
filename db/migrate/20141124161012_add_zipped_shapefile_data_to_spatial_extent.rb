class AddZippedShapefileDataToSpatialExtent < ActiveRecord::Migration
  def up
    SpatialExtent.find_each do |s|
      s.zipped_shapefile_file_name    = "#{s.tablename}.zip"
      f = File.open("#{Rails.public_path}/system/spatial_extents/zipped_shapefiles/#{s.zipped_shapefile_file_name}")
      s.zipped_shapefile_file_size    = f.size
      s.zipped_shapefile_content_type = IO.popen(["file", "--brief", "--mime-type", f.path], in: :close, err: :close).read.chomp
      s.zipped_shapefile_updated_at   = Time.now
      if !s.valid?
        puts s.errors.full_messages 
      end
      s.save
    end
  end

  def down
    SpatialExtent.find_each do |s|
      s.update_attributes(zipped_shapefile_file_name:    nil,
                          zipped_shapefile_file_size:    nil,
                          zipped_shapefile_content_type: nil,
                          zipped_shapefile_updated_at:   nil)
    end
  end
end
