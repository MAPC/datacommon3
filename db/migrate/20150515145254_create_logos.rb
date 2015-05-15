class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.string :alt_text
      t.attachment :image
      t.integer :sort_order

      t.timestamps
    end
  end
end
