class MunicipalitiesController < ApplicationController
  before_filter :load_institution
  
  def index
    @geographies = Municipality.all.sort {|e,f| e.unitid.to_i <=> f.unitid.to_i }
    render 'snapshots/index'
  end

  def show
    @s = Snapshot.new( Municipality.find_by(slug: params[:id]) )
    render 'snapshots/show'
  end

  def topic
    geography = Municipality.find_by(slug: params[:municipality_id])
    topic     = IssueArea.find_by(slug: params[:id])

    @s = Snapshot.new(geography, topic)
    render 'snapshots/topic'
  end
end
