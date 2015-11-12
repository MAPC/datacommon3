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
    # TODO may be able to avoid this call altogether if
    # sessionstate checks for correct_viewer and correct_user,
    # which it should.
    @visualization = Visualization.unscoped.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @visualization.sessionstate }
    end
  end

  def upload_image
    @visual  = Visualization.unscoped.find_by id: params[:id]
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
    template = Visualization.unscoped.find_by(id: params[:id])
    @visualization = template.dup
    @visualization.assign_attributes(
      title:          "#{template.title} (Copy)",
      owner_id:       current_user.id,
      original_id:    template.id,
      institution_id: @institution.id
    )
    # TODO: Hacky fix. Why doesn't ActiveRecord recognize this timestamp?
    @visualization.updated_at = Time.now

    # TODO: write a test for duplicating a visualization
    # with no abstract.
    @visualization.save(validate: false)
    redirect_to edit_visualization_url(@visualization)
  rescue => e
    trigger_airbrake(e)
    danger "An unexpected error occurred when duplicating the visualization.\n#{e}"
    if @visualization.errors.any?
      flash[:danger] << "#{ @visualization.errors.full_messages.join(", ") }"
    end
    redirect_to root_url
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
    @visualization = Visualization.unscoped.find(params[:id])
    @visualization.destroy

    flash[:success] = "You deleted the visualization \"#{@visualization}\"."
    # TODO: Maybe profile_path(current_user)
    redirect_to current_user
  end


  private

    def editable_params
      params.require(:visualization)
            .permit(:title, :year, :abstract, :institution_id,
                    :permission, :sessionstate, {issue_area_ids: []},
                    {data_source_ids: []})
    end

    def signed_in_user
      unless signed_in?
        warning :visual_sign_in_first
        store_location
        redirect_to login_url
      end
    end


    def correct_viewer
      @visualization = Visualization.unscoped.find_by(id: params[:id])

      if @visualization.nil?
        danger :visual_not_found
        redirect_to visualizations_url
      elsif @visualization.private? && !current_user?(@visualization.owner)
        danger :visual_only_owner_may_view
        redirect_to visualizations_url
      end
    end


    def correct_user
      @visualization = Visualization.unscoped.find_by(id: params[:id])

      if @visualization.nil?
        danger :visual_not_found
        redirect_to visualizations_url
      elsif !current_user?(@visualization.owner)
        store_location
        danger :visual_only_owner_may_edit
        redirect_to login_url
      end
    end

end
