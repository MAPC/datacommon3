class AddInstitutionToStaticMap < ActiveRecord::Migration
  def change
    add_column :mbdc_calendar, :institution_id, :integer, default: 1
  end
end
