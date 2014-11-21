class AddImageColumnsToVisualizations < ActiveRecord::Migration
  def up
    add_attachment :weave_visualization, :image
  end

  def down
    remove_attachment :weave_visualization, :image
  end
end
