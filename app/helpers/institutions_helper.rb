module InstitutionsHelper

  def featured_visualization
    Visualization.featured.sample
  end


  def recent_visualizations
    Visualization.recent(4)
  end

  alias_method :featured_vis, :featured_visualization
  alias_method :feature,      :featured_visualization

end
