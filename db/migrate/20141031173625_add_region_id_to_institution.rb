class AddRegionIdToInstitution < ActiveRecord::Migration
  def change
    add_column :institutions, :region_id, :integer
  end
end
