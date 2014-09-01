class AddInstitutionIdToSnapshotsRegionalunit < ActiveRecord::Migration
  def change
    add_column :snapshots_regionalunit, :institution_id, :integer, default: 1
  end
end
