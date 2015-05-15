module InstitutionsHelper

  def recent_visualizations(count=4)
    Visualization.recent(count)
  end

  def object_list(type, visualization, options={})
    value        = options.fetch(:value) { :id }
    display_name = options.fetch(:display_name) { type.to_s.humanize.singularize }
    links = visualization.send(type).map {|obj|
      link_to obj.title, "/visualizations?#{ type.to_s.singularize }=#{obj.send(value)}"
    }
    link_text = links.join(', ')
    plural_display_name = display_name.pluralize(links.length)
    "#{plural_display_name}: #{link_text}".html_safe
  end

  def data_sources_list(visualization)
    object_list(:data_sources, visualization)
  end

  def issue_areas_list(visualization)
    object_list(:issue_areas, visualization, value: :slug, display_name: "Topic")
  end
end
