module SnapshotsHelper

  def options_for_area(type, selected)
    geographies = Geography
                    .institution(@institution, only: true)
                    .pluck(:name, :slug)

    options_for_select(geographies, selected.try(:slug))
  end

end