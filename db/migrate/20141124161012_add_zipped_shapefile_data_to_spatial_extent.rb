# ActiveRecord::Base.establish_connection :geographic

class AddZippedShapefileDataToSpatialExtent < ActiveRecord::Migration

  disable_ddl_transaction!

  def up
    SpatialExtent.find_each do |s|
      puts "SpatialExtent: #{s.id} #{s.title}"
      s.zipped_shapefile_file_name = "#{s.tablename}.zip"
      puts "URL: #{s.zipped_shapefile.url}"
      
      file = open(s.zipped_shapefile.url) {|f| f.read }
      s.zipped_shapefile_file_size    = file.size

      # Next line used to be
      # IO.popen(["file", "--brief", "--mime-type", f.path], in: :close, err: :close).read.chomp
      s.zipped_shapefile_content_type = 'application/zip' 
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
