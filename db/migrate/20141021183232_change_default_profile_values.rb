class ChangeDefaultProfileValues < ActiveRecord::Migration
  def change
    change_column_default :maps_contact, :mapc_newsletter, false
    change_column_default :maps_contact, :mbdc_newsletter, false
    change_column_default :maps_contact, :last_modified,   Time.now
  end
end
