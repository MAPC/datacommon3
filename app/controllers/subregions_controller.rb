class SubregionsController < ApplicationController
  
  def index
    @geographies = Subregion.all.sort {|e,f| e.unitid.to_i <=> f.unitid.to_i }
    render 'snapshots/index'
  end

  def show
    @geography = Subregion.find_by(slug: params[:id])
    render 'snapshots/show'
  end

  def topic
    @geography  = Subregion.find_by(slug: params[:municipality_id])
    @topic = IssueArea.find_by(slug: params[:id])
    render 'snapshots/topic'
  end
end
