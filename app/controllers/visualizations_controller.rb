class VisualizationsController < ApplicationController
  before_filter :load_institution
  before_action :signed_in_user, only: [:new, :create]
  before_action :correct_viewer, only: [:show]
  # before_action :correct_user, only: [:edit, :update, :destroy]

  has_scope :topic
  has_scope :data_source

  def index
    visualizations = apply_scopes(Visualization.institution(@institution)).page(params[:page])
    @gallery = Gallery.new(visualizations)
  end


  def show
  end


  def new
    @visualization = Visualization.new(institution_id: @institution)
  end


  def create
    @visualization = Visualization.new new_params
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


  private

    def new_params
      params.require(:visualization).permit(:title, :year, :abstract, 
                                {issue_area_ids:  []},
                                {data_source_ids: []},
                                :institution_id,
                                :permission,
                                :sessionstate)
    end

    def signed_in_user
      unless signed_in?
        flash[:warning] = "Please sign in before creating a visualization."
        store_location
        redirect_to signin_url
      end
    end


    def correct_viewer
      @visualization = Visualization.unscoped.find(params[:id])

      if @visualization.private? && !current_user?(@visualization.owner)
        flash[:danger] = "Only the owner of a private visualization may view it."
        redirect_to visualizations_url
      end
    end

    def correct_user
      @visualization = Visualization.find(params[:id])
      
      unless current_user?(@user)
        flash[:danger] = <<-EOE
          You must be logged in as the owner in order to edit this visualization.
        EOE
  
        store_location
        redirect_to signin_url
      end
    end

end
