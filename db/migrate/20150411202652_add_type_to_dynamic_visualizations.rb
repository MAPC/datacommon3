class AddTypeToDynamicVisualizations < ActiveRecord::Migration
  def up
    add_column :snapshots_visualization, :type, :string
    
    conversions = [nil, "municipality", nil, nil, nil, "subregion"]
    DynamicVisualization.find_each do |visual|
      visual.update_attribute(:type, conversions[visual.regiontype_id])
    end
  end

  def down
    remove_column :snapshots_visualization, :type, :string
  end
end