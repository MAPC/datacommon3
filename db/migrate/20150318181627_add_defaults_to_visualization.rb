class AddDefaultsToVisualization < ActiveRecord::Migration
  def change
    change_column_default :snapshots_visualization, :overviewmap, false
  end
end
