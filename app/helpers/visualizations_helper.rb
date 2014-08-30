module VisualizationsHelper

  def topic_options
    options  = IssueArea.all.map {|i| [i.title, i.slug]}
    options.unshift ['All Topics', nil]
  end

  def data_source_options
    options  = DataSource.all.map {|i| [i.title, i.id]}
    options.unshift ['All Data Sources', nil]
  end

end
