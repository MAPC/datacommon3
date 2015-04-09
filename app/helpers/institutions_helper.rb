module InstitutionsHelper

  def recent_visualizations(count=4)
    Visualization.recent(count)
  end

  def data_sources_list(visualization)
    links = visualization.data_sources.map do |ds| 
      link_to ds.title, "/visualizations?data_source=#{ds.id}"
    end
    link_text = links.join(', ')

    ("Data source".pluralize(links.length) << ": #{link_text}").html_safe
  end

  def issue_areas_list(visualization)
    links = visualization.issue_areas.map do |ia|
      link_to ia.title, "/visualizations?topic=#{ia.slug}"
    end
    link_text = links.join(', ')

    ("Topic".pluralize(links.length) << ": #{link_text}").html_safe
  end



end
