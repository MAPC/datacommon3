class AddInstitutionToVisualization < ActiveRecord::Migration
  def change
    add_column :weave_visualization, :institution_id, :integer, default: 1
  end
end
