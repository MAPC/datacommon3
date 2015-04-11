class SnapshotFacade

  attr_reader :geography, :topic, :visualizations, :type

  def initialize(options={})
    @geography = Geography.find_by(slug: options.fetch(:geography))
    @topic     = IssueArea.find_by(slug: options.fetch(:topic))
    @visualizations = @topic.dynamic_visualizations.where(type: @geography.type)
    @type = @geography.type
  end

  def to_s
    "#{@geography} -- #{@topic}".html_safe
  end

  def to_html
    "#{@geography.name} &mdash; #{@topic.title}".html_safe
  end

  alias_method :visuals, :visualizations

end