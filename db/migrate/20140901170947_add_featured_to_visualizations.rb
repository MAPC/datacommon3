class AddFeaturedToVisualizations < ActiveRecord::Migration
  def change
    add_column :weave_visualization, :featured, :integer, default: nil
  end
end
