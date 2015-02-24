class ChangeDefaultProfileValues < ActiveRecord::Migration
  def change
    change_column_default :maps_contact, :mapc_newsletter, false
    change_column_default :maps_contact, :mbdc_newsletter, false
    execute('ALTER TABLE "maps_contact" ALTER COLUMN "last_modified" SET DEFAULT CURRENT_DATE')
  end
end
