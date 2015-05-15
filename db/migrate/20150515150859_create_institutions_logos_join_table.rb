class CreateInstitutionsLogosJoinTable < ActiveRecord::Migration
  def change
    create_join_table :institutions, :logos do |t|
      t.index [:institution_id, :logo_id]
      t.index [:logo_id, :institution_id]
    end
  end
end
