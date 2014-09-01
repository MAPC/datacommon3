module InstitutionsHelper

  def recent_visualizations
    Visualization.recent(4)
  end

end
