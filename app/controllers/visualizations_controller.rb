class VisualizationsController < ApplicationController
  before_filter :load_institution

  before_action :signed_in_user, only: [:new, :create]
  before_action :correct_viewer, only: [:show]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  has_scope :topic
  has_scope :data_source

  def index
    @visualizations = apply_scopes(
      Visualization.institution(@institution)
    ).page(params[:page])
  end


  def show
  end

  def session_state
    @visualization = Visualization.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @visualization.sessionstate }
    end
  end

  def upload_image
    @visual  = Visualization.find_by id: params[:id]
    decoded_file = Base64.decode64 params[:data]
    
    begin
      file = Tempfile.new([@visual.id.to_s, ".png"])
      file.binmode
      file.write decoded_file

      @visual.image = file
      @visual.image_content_type = 'image/png'

      file.close

      if @visual.save!
        render json: { message: "Successfully uploaded preview." }
      else
        render json: { message: "#{@visual.errors.full_messages.join(", ")}",
                       status: :unprocessable_entity }
      end
    ensure
      file.unlink
    end
  end


  def new
    @visualization = Visualization.new(institution_id: @institution)
  end


  def create
    @visualization = Visualization.new editable_params
    @visualization.owner_id = current_user.id

    respond_to do |format|
      if @visualization.save
        format.json { render json: @visualization }
      else
        format.json { render json:   @visualization.errors.full_messages,
                             status: :unprocessable_entity }
      end
    end
  end


  def duplicate
    template = Visualization.find_by(id: params[:id])
    @visualization = template.dup
    @visualization.assign_attributes(
      title:          "#{template.title} (Copy)",
      owner_id:       current_user.id,
      original_id:    template.id,
      institution_id: nil
    )

    if @visualization.save
      redirect_to edit_visualization_url(@visualization)
    else
      flash[:danger] = 'An unexpected error occurred when duplicating the visualization.'
      redirect_to root_url
    end
  end

  
  def edit
  end


  def update
    @visualization.update! editable_params
    
    respond_to do |format|
      if @visualization.save
        format.json { render json: @visualization }
      else
        format.json { render json:   @visualization.errors.full_messages,
                             status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @visualization = Visualization.find(params[:id])
    @visualization.destroy

    flash[:success] = "You deleted the visualization \"#{@visualization}\"."
    redirect_to current_user
  end


  private

    def editable_params
      params.require(:visualization).permit(:title,
                                            :year,
                                            :abstract,
                                            :institution_id,
                                            :permission,
                                            :sessionstate,
                                            {issue_area_ids:  []},
                                            {data_source_ids: []})
    end


    SIGN_IN_FIRST = "Please sign in before you create a visualization."

    ONLY_OWNER_MAY_VIEW = <<-EOE
      This visualization has been made private. Only its owner may view it.
    EOE

    ONLY_OWNER_MAY_EDIT = <<-EOE
      Is this your visualization? Please log in to edit it.
    EOE


    def signed_in_user
      unless signed_in?
        flash[:warning] = SIGN_IN_FIRST
        store_location
        redirect_to login_url
      end
    end


    def correct_viewer
      @visualization = Visualization.unscoped.find(params[:id])

      if @visualization.private? && !current_user?(@visualization.owner)
        flash[:danger] = ONLY_OWNER_MAY_VIEW
        redirect_to visualizations_url
      end
    end


    def correct_user
      @visualization = Visualization.unscoped.find(params[:id])
      
      unless current_user?(@visualization.owner)
        flash[:danger] = ONLY_OWNER_MAY_EDIT
        store_location
        redirect_to login_url
      end
    end

end
