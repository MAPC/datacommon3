class SubregionsController < ApplicationController
  before_filter :load_institution
  
  def index
    @geographies = Subregion.all.sort {|e,f| e.unitid.to_i <=> f.unitid.to_i }
    render 'snapshots/index'
  end

  def show
    @s = Snapshot.new( Subregion.find_by(slug: params[:id]) )
    render 'snapshots/show'
  end

  def topic
    geography  = Subregion.find_by(slug: params[:subregion_id])
    topic      = IssueArea.find_by(slug: params[:id])

    @s = Snapshot.new( geography, topic )
    
    render 'snapshots/topic'
  end
end
