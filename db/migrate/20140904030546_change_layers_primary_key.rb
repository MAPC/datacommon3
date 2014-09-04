class ChangeLayersPrimaryKey < ActiveRecord::Migration
  def up
    remove_column :layers, :id
    add_column    :layers, :id, :primary_key
    add_column    :layers, :primarykey, :string
  end

  def down
    remove_column :layers, :primarykey
    remove_column :layers, :id
    add_column    :layers, :id, :string
    execute "ALTER TABLE layers ADD PRIMARY KEY (id);"
  end
end
