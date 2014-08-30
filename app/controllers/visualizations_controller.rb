class VisualizationsController < ApplicationController
  before_filter :load_institution

  has_scope :topic
  has_scope :data_source

  def index
    visualizations = apply_scopes(Visualization).all.page(params[:page])
    # topic       = IssueArea.find_by(slug: params[:topic])
    # data_source = IssueArea.find    params[:data_source]

    @gallery    = Gallery.new(visualizations)#, topic, data_source)
  end

  def show
    @visualization = Visualization.showing.find params[:id]
  end
end
