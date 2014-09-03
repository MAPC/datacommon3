class VisualizationsController < ApplicationController
  before_filter :load_institution
  before_action :signed_in_user, only: [:new, :create]
  # before_action :correct_user, only: [:edit, :update, :destroy]

  has_scope :topic
  has_scope :data_source

  def index
    visualizations = apply_scopes(Visualization.institution(@institution)).page(params[:page])
    @gallery = Gallery.new(visualizations)
  end


  def show
    @visualization = Visualization.showing.find params[:id]
  end


  def new
    @visualization = Visualization.new(institution_id: @institution)
  end


  def create
    @visualization = Visualization.new new_params
    if @visualization.save
      flash[:success] = "Great! You saved your visualizations successfully!"
    else
      render 'new'
    end
  end


  private

    def new_params
      params.require(:visualization).permit(:title, :year, :abstract, 
                                            :issue_area_ids,
                                            :data_source_ids,
                                            :institution_id,
                                            :permission)
    end

    def signed_in_user
      unless signed_in?
        flash[:danger] = "Please sign in before creating a visualization."
        store_location
        redirect_to signin_url
      end
    end


    def correct_user
      @visualization = Visualization.showing.find(params[:id])
      
      unless current_user?(@user)
        flash[:danger] = <<-EOE
          You must be logged in as the owner in order to edit this visualization.
        EOE
  
        store_location
        redirect_to signin_url
      end
    end

end
