module SnapshotsHelper

  def options_for_area(type, selected)
    # TODO: Don't break the Law of Demeter
    geographies = Geography
                    .pluck(:name, :slug)
                    # .where(type: params[:type])
                    # .where(institution_id: @institution.id)
                      
    options_for_select(geographies, selected)
  end

end