class VisualizationsController < ApplicationController
  before_filter :load_institution

  def index
    @visualizations = Visualization.all
  end

  def show
    @visualization = Visualization.showing.find params[:id]
  end
end
