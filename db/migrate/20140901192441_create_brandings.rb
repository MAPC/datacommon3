class CreateBrandings < ActiveRecord::Migration
  def change
    create_table :brandings do |t|
      t.integer :institution_id
      t.string  :logo_url
      t.string  :tagline
      t.string  :map_gallery_intro
      t.text    :logos, default: "[]"
      t.string  :address
      t.string  :phone_number
      t.string  :email
    end
  end
end