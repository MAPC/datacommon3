class RenamePrimaryKeyToJoinKey < ActiveRecord::Migration
  def change
    rename_column :layers, :primarykey, :join_key
    add_column    :layers, :datesavail, :string
  end
end
