module SnapshotsHelper

  def snapshot_topics(type)
    issue_areas = DynamicVisualization.where(type: type).map {|d|
      d.issue_areas.map(&:slug)
    }.flatten.uniq
    IssueArea.where(slug: issue_areas)
  end

  def options_for_area(type, selected)
    geographies = Geography
                    .institution(@institution, only: true)
                    .pluck(:name, :slug)

    options_for_select(geographies, selected.try(:slug))
  end

end