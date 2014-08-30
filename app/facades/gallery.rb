class Gallery

  attr_reader :visualizations#, :topic, :data_source

  def initialize(visualizations)#, topic, data_source)
    @visualizations = visualizations
    # @topic          = topic
    # @data_source    = data_source
  end

end