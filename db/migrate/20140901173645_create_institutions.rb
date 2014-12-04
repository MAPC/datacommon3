class CreateInstitutions < ActiveRecord::Migration
  def up
    create_table :institutions do |t|
      t.string :short_name
      t.string :long_name
      t.string :subdomain
    end

    Institution.create_or_update({ id: 1, short_name: "Metro Boston", long_name: "Metropolitan Boston",   subdomain: "metroboston" })
    Institution.create_or_update({ id: 2, short_name: "Central Mass", long_name: "Central Massachusetts", subdomain: "centralmass" })
  end

  def down
    drop_table :institutions
  end
end
