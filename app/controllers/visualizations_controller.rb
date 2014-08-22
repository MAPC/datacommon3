class VisualizationsController < ApplicationController
  before_filter :load_institution

  def index
    @visualizations = Visualization.all.page params[:page]
    # @visualizations = Visualization.institution(@institution).page params[:page]
  end

  def show
    @visualization = Visualization.showing.find params[:id]
  end
end
