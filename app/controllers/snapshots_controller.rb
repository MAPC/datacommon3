class SnapshotsController < ApplicationController

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
      format.xml { render xml: @visual.rendered_state(object) }
    end
  end


  def upload_image
    @visual  = DynamicVisualization.find_by id: params[:id]
    png_data = Base64.decode64 params[:data]
    
    filename = @visual.preview(object).path
    make_directory_for filename
    
    File.open(filename, 'wb') do |f|
      f.write Base64.decode64(png_data)
    end

    respond_to do |format|
      # If the file is there (i.e. if it saved)
      f.exists? ? format.json { render json: true } : format.json { render json: false }
    end
  end
  
end