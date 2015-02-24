class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :institution_id
      t.integer :sort_order
      t.string  :topic_id
      t.string  :slug
    end
  end
end
