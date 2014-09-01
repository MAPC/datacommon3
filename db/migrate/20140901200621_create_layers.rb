class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers, id: false do |t|
      t.string  :id
      t.string  :title
      t.string  :alt_title
      t.string  :descriptn
      t.string  :subject
      t.string  :creator
      t.string  :createdate
      t.string  :moddate
      t.string  :publisher
      t.string  :contributr
      t.string  :coverage
      t.string  :universe
      t.string  :schema
      t.string  :tablename
      t.string  :tablenum
      t.integer :institution_id
    end
  end
end
