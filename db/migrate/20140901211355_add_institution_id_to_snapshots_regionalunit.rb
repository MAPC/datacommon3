class AddInstitutionIdToSnapshotsRegionalunit < ActiveRecord::Migration
  def change
    add_column :snapshots_regionalunit, :institution_id, :integer, default: 1

    # Assign municipalities to Central Mass
    munis = [17,21,28,32,39,45,54,77,80,84,110,124,134,138,151,179,186,188,202,212,215,216,222,226,228,241,257,271,278,280,287,290,303,304,311,316,321,323,328,348,11,12,15,19,64,97,103,115,125,140,147,153,162,234,235,255,270,282,294,299,332,343]
    munis.each do |id|
      begin
        m = Municipality.find_by(unitid: id.to_s)
        m.update_attribute(:institution_id, 2)
        m.update_attributes(short_desc: m.name, _short_desc_rendered: m.name)
      rescue
      end
    end

  end
end
