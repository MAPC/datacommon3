class CreateInstitutions < ActiveRecord::Migration
  def up
    create_table :institutions do |t|
      t.string :short_name
      t.string :long_name
      t.string :subdomain
    end
  end

  def down
    drop_table :institutions
  end
end
