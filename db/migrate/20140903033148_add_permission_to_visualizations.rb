class AddPermissionToVisualizations < ActiveRecord::Migration
  def change
    add_column :weave_visualization, :permission, :string, default: "private"
  end
end
