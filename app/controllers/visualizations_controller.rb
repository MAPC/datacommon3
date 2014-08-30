class VisualizationsController < ApplicationController
  before_filter :load_institution

  def index
    if params[:topic]
      topic          = IssueArea.find_by(slug: params[:topic])
      visualizations = topic.visualizations.page params[:page]
      
      @gallery = Gallery.new(visualizations, topic)
    else
      @gallery = Gallery.new( Visualization.all.page(params[:page]) )
    end
  end

  def show
    @visualization = Visualization.showing.find params[:id]
  end
end
