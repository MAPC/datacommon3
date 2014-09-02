class AddInstitutionIdToHero < ActiveRecord::Migration
  def change
    add_column :heros, :institution_id, :integer, default: 1
  end
end
