class SnapshotsController < ApplicationController
  before_filter :load_institution

  def index
  end

  # /snapshots/:slug
  # /snapshots/{boston|cambridge}
  def show
    if ["cities-and-towns", "subregions"].include? params[:id]
      flash[:info] =<<-EOS
        We've moved things around a little!
        This is the new home for snapshots
        for cities, towns, and subregions.
      EOS
      redirect_to snapshots_path
    end

    @geography = Geography.find_by(slug: params[:id])
  end

  # /snapshots/:slug/:topic
  # /snapshots/boston/{economy|demographics}
  def detail
    if ["cities-and-towns", "subregions"].include? params[:snapshot_id]
      flash[:info] =<<-EOS
        We've moved things around a little!
        This is the new home for snapshots
        for cities, towns, and subregions.
      EOS
      redirect_to snapshot_path params[:id]
    else
      # Correct request
      @snapshot = SnapshotFacade.new(
        geography: params[:snapshot_id],
        topic:     params[:id]
      )
    end
  end

  def session_state
    # TODO: Assert needs up front.
    @visual = DynamicVisualization.find_by id: params[:id]
    object  = Geography.find_by slug: params[:geography]

    respond_to do |format|
      format.xml  { render xml:  @visual.rendered_state(object) }
      format.json { render json: @visual.rendered_state(object) }
    end
  end


  def upload_image
    @visual      = DynamicVisualization.find_by id: params[:id]
    object       = Geography.find_by slug: params[:geography]
    decoded_file = Base64.decode64(params[:data]).force_encoding(Encoding::ASCII_8BIT)
    s3 = AWS::S3.new


    paperclip_defaults = Rails.configuration.paperclip_defaults
    # If S3 storage, use the S3 uploader
    if paperclip_defaults[:storage] == :s3
      filename = @visual.preview(object).potential_path
      bucket_name = paperclip_defaults[:s3_credentials][:bucket]
      bucket      = s3.buckets[bucket_name]

      tempfile = Tempfile.new('uuid', encoding: Encoding::ASCII_8BIT)
      begin
        tempfile.write(decoded_file)
        tempfile.close
        s3_object = bucket.objects[filename[1..-1]]
        s3_object.write( file: tempfile.path , acl: :public_read )

        render json: { message: "Successfully uploaded preview to #{filename}." }
      rescue StandardError => e
        render json: { message: "Did not successfully save S3 because #{e}." }, status: :unprocessable_entity
      ensure
        tempfile.unlink
      end

    else # use filesystem storage
      # Uses the preview#path helper defined in the model.
      filename = @visual.preview(object).potential_path
      make_directory_for filename
      # Write PNG data to the file
      File.open(filename, 'wb') {|f| f.write decoded_file }
      render json: json_for_file(filename)
    end

  end

  private

    def json_for_file(filename)
      if File.exists? filename
        { message: "Successfully uploaded preview to #{filename}." }
      else
        { message: "Did not successfully save.",
          status:  :unprocessable_entity       }
      end
    end


    def make_directory_for(filename)
      dirname = File.dirname(filename)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end
  
end

