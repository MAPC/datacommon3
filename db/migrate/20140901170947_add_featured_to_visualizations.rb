class AddFeaturedToVisualizations < ActiveRecord::Migration
  def change
    add_column :visualizations, :featured, :integer, default: nil
  end
end
