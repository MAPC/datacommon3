class SwitchDjangoTimestampsToRailsTimestamps < ActiveRecord::Migration
  def change
    rename_column :auth_user, :date_joined,   :created_at

    rename_column :maps_contact,        :last_modified, :updated_at
    rename_column :weave_visualization, :last_modified, :updated_at
  end
end
