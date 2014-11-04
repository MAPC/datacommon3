class SubregionsController < ApplicationController
  before_filter :load_institution
  
  def index
    @geographies = Subregion.only_inst(@institution)
    render 'snapshots/index'
  end


  def show
    subregion = Subregion.find_by(slug: params[:id])
    topics    = IssueArea.all.map do |topic|
      visual  = topic.dynamic_visualizations.where(regiontype_id: 5).first # 5 = Subregion
      OpenStruct.new(topic: topic, visual: visual) unless visual.nil?
    end

    @s = Snapshot.new(subregion, topics.compact, @institution)
    render 'snapshots/show'
  end


  def topic
    subregion = Subregion.find_by(slug: params[:subregion_id])
    topic     = IssueArea.find_by(slug: params[:id])
    vis       = topic.dynamic_visualizations.where(regiontype_id: 5).order(:title)

    @s = TopicSnapshot.new(subregion, vis, topic)
    render 'snapshots/topic'
  end


  def rendered_state
    subregion = Subregion.find_by(slug: params[:id])
    vis       = DynamicVisualization.find_by(id: params[:vis_id])
    @state    = vis.rendered_state(subregion)
    render xml: @state
  end
end
