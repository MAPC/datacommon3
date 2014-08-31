class MunicipalitiesController < ApplicationController
  before_filter :load_institution
  
  def index
    @geographies = Municipality.all.sort {|e,f| e.unitid.to_i <=> f.unitid.to_i }
    render 'snapshots/index'
  end

  def show
    muni   = Municipality.find_by(slug: params[:id])
    topics = IssueArea.all.map do |topic|
      visual = topic.dynamic_visualizations.where(regiontype_id: 1).first # 1 = Municipality
      OpenStruct.new(topic: topic, visual: visual) unless visual.nil?
    end

    @s = Snapshot.new(muni, topics.compact)
    render 'snapshots/show'
  end

  def topic
    muni   = Municipality.find_by(slug: params[:municipality_id])
    topic  = IssueArea.find_by(slug: params[:id])
    vis    = topic.dynamic_visualizations.where(regiontype_id: 1)

    @s = TopicSnapshot.new(muni, vis, topic)
    render 'snapshots/topic'
  end

  def rendered_state
    muni = Municipality.find_by(slug: params[:id])
    vis  = DynamicVisualization.find_by(id: params[:vis_id])
    @state = vis.rendered_state(muni)
    render xml: @state
  end
end
