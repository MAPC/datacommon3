class VisualizationsController < ApplicationController
  before_filter :load_institution

  has_scope :topic
  has_scope :data_source

  def index
    visualizations = apply_scopes(Visualization).all.page(params[:page])
    @gallery = Gallery.new(visualizations)
  end

  def show
    @visualization = Visualization.showing.find params[:id]
  end
end
