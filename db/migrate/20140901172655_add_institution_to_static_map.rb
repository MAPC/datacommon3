class AddInstitutionToStaticMap < ActiveRecord::Migration
  def change
    add_column :static_maps, :institution_id, :integer, default: 1
  end
end
