ActiveRecord::Base.establish_connection :geographic

class AddDescriptionToSpatialExtent < ActiveRecord::Migration
  def change
    add_column :'_geo_extents', :desc, :text
  end
end
