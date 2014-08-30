module VisualizationsHelper


  def topic_options
    IssueArea.all.map {|i| [i.title, visualizations_path(topic: i)]}
  end

  def data_source_options
    DataSource.all.map {|i| [i.title, i.id]}
  end

end
