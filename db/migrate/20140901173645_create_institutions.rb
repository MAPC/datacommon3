class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :short_name
      t.string :long_name
      t.string :subdomain
    end
  end
end
