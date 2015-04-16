class SnapshotsController < ApplicationController
  before_filter :load_institution

  def index
  end

  # /snapshots/:slug
  # /snapshots/{boston|cambridge}
  def show
    @geography = Geography.find_by(slug: params[:id])
  end

  # /snapshots/:slug/:topic
  # /snapshots/boston/{economy|demographics}
  def detail
    @snapshot = SnapshotFacade.new(
      geography: params[:snapshot_id],
      topic:     params[:id]
    )
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
    decoded_file = Base64.decode64 params[:data]
    
    # Uses the preview#path helper defined in the model.
    filename = @visual.preview(object).potential_path
    make_directory_for filename

    # Write PNG data to the file
    File.open(filename, 'wb') { |f| f.write decoded_file }
    
    if File.exists? filename
      render json: { message: "Successfully uploaded preview to #{filename}." }
    else
      render json: { message: "Did not successfully save.",
                     status: :unprocessable_entity }
    end

  end

  private
    def make_directory_for(filename)
      dirname = File.dirname(filename)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end
  
end

