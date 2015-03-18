class AddTypeToGeography < ActiveRecord::Migration
  def change
    add_column :snapshots_regionalunit, :type, :string, default: 'municipality'
  end
end
