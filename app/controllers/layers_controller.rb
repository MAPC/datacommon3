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
    if Rails.env == 'production'
      sys_path = "https://s3.amazonaws.com/#{ENV.fetch('S3_BUCKET_NAME')}"
    else
      sys_path = Rails.public_path, 'system'
    end



    tabular_dir  = File.join( sys_path, 'layers', 'csvs' )
    metadata_dir = File.join( sys_path, 'layers', 'metadata' )
    spatial_dir  = File.join( sys_path, 'spatial_extents', 'zipped_shapefiles' )
    
    tabular  = File.join tabular_dir,  "#{layer.tablename}#{extent.table_suffix}.csv"
    metadata = File.join metadata_dir, "#{layer.tablename}#{extent.table_suffix}_meta.csv"
    spatial  = File.join spatial_dir,  "#{extent.tablename}.zip"

    if Rails.env == 'production'
      tabular  = open(tabular)   {|f| f.read}
      spatial  = open(spatial)   {|f| f.read}
      metadata = open(metadata) {|f| f.read}
    else
      tabular  = File.open(tabular)
      spatial  = File.open(spatial)
      metadata = File.open(metadata)
    end
    
    zip_file_name = File.join(Rails.root, 'tmp', 'downloads', "#{layer.title} (#{extent.title}).zip")

    unless File.exists? zip_file_name
      FileUtils.mkdir_p( File.dirname(zip_file_name) )

      Zip::File.open( zip_file_name, Zip::File::CREATE) do |zip|
        [tabular, metadata, spatial].each do |file|
          assert_file_exists file
          filename = file.path.rpartition('/').last
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
