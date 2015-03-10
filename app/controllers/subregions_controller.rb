class SubregionsController < ApplicationController
  before_filter :load_institution
  
  def index
    @geographies = @institution.subregions
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

  def image
    puts "#image"
    data = params[:data]
    png_data = data.split(',').last
    png = Base64.decode64 png_data

    filename = "#{Rails.public_path}/dynamic_visualizations/images/#{params[:subregion_id]}/#{params[:id]}.png"
    dirname = File.dirname(filename) 
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

    File.open(filename, 'wb') {|f| f.write png }

    render status: 200
  end
end
