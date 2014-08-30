class Gallery

  attr_reader :visualizations, :topic

  def initialize(visualizations, topic=nil)
    @visualizations = visualizations
    @topic          = topic || NullObjects::NullIssueArea.new

  end

end