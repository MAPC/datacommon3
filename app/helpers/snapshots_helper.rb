module SnapshotsHelper

  def snapshot_topics
    IssueArea.all.reject{|t| 
      %w(arts-culture land-use-zoning public-safety technology).include? t.slug
    }
  end

  def options_for_area(type, selected)
    geographies = Geography
                    .institution(@institution, only: true)
                    .pluck(:name, :slug)

    options_for_select(geographies, selected.try(:slug))
  end

end