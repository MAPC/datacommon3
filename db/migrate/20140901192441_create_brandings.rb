class CreateBrandings < ActiveRecord::Migration
  def change
    create_table :brandings do |t|
      t.integer :institution_id
      t.string  :logo_url
      t.string  :tagline
      t.string  :map_gallery_intro
    end
    
    Branding.create_or_update({ id: 1, institution_id: 1 })
    Branding.create_or_update({ id: 2, institution_id: 2 })
  end
end