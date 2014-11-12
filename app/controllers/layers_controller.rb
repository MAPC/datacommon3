class LayersController < ApplicationController
  before_filter :load_institution

  
  def index
    @layers = Layer.all.page params[:page] #institution(@institution)
  end

  
  def show
    @layer  = Layer.find_by(tablename: params[:id])
  end


  def download
    layer  = Layer.find_by tablename: params[:id]
    extent = SpatialExtent.find params[:extent_id]

    exports = File.join Rails.public_path, 'layers', 'exports'
    tabular = File.join exports, 'tabular'
    spatial = File.join exports, 'spatial'

    spatial_files = Dir.glob( File.join(spatial, "#{extent.tablename}*") )
    tabular_files = Dir.glob( File.join(tabular, "#{layer.tablename}#{extent.table_suffix}.csv") )
    metadata_file = Dir.glob( File.join(tabular, "#{layer.tablename}#{extent.table_suffix}_meta.csv") )

    zip_file_name = File.join(Rails.root, 'tmp', 'downloads', "#{layer.title} (#{extent.title}).zip")

    unless File.exists? zip_file_name
      FileUtils.mkdir_p( File.dirname(zip_file_name) )

      Zip::File.open( zip_file_name, Zip::File::CREATE) do |zip|
        [spatial_files, tabular_files, metadata_file].flatten.uniq.each do |file|
          assert_file_exists file
          filename = file.rpartition('/').last
          zip.add(filename, file)
        end
      end
    end

    send_file zip_file_name, filename: "#{File.basename(zip_file_name)}", type: :zip
  end

  

  private

  def assert_file_exists(file)
    puts file.inspect
    unless File.exists? file
      raise IOError, "File at #{file} could not be found."
    end
  end


end
