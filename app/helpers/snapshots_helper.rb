module SnapshotsHelper

  def options_for_area(type, selected)
    # TODO: Don't break the Law of Demeter
    geographies = Geography
                    .institution(@institution)
                    .pluck(:name, :slug)
                    # .where(type: params[:type])
                    
                      
    options_for_select(geographies, selected)
  end

end