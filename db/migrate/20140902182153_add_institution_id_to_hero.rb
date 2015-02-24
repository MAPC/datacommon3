class AddInstitutionIdToHero < ActiveRecord::Migration
  def change
    add_column :mbdc_hero, :institution_id, :integer, default: 1
  end
end
