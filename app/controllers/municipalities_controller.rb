class MunicipalitiesController < ApplicationController
  before_filter :load_institution
  
  def index
    @geographies = Municipality.only_inst(@institution)
    render 'snapshots/index'
  end


  def show
    muni   = Municipality.find_by(slug: params[:id])
    topics = IssueArea.all.map do |topic|
      visual = topic.dynamic_visualizations.where(regiontype_id: 1).first # 1 = Municipality
      OpenStruct.new(topic: topic, visual: visual) unless visual.nil?
    end

    @s = Snapshot.new(muni, topics.compact, @institution)
    render 'snapshots/show'
  end


  def topic
    muni   = Municipality.find_by(slug: params[:municipality_id])
    topic  = IssueArea.find_by(slug: params[:id])
    vis    = topic.dynamic_visualizations.where(regiontype_id: 1).order(:title)

    @s = TopicSnapshot.new(muni, vis, topic)
    render 'snapshots/topic'
  end


  def rendered_state
    muni = Municipality.find_by(slug: params[:id])
    vis  = DynamicVisualization.find_by(id: params[:vis_id])
    @state = vis.rendered_state(muni)
    render xml: @state
  end


  def image
    puts "#image"
    data = params[:data]
    png_data = data.split(',').last
    png = Base64.decode64 png_data

    filename = "#{Rails.public_path}/dynamic_visualizations/images/#{params[:municipality_id]}/#{params[:id]}.png"
    dirname = File.dirname(filename) 
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

    File.open(filename, 'wb') {|f| f.write png }

    render status: 200
  end
end
