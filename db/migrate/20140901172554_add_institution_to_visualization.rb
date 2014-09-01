class AddInstitutionToVisualization < ActiveRecord::Migration
  def change
    add_column :visualizations, :institution_id, :integer, default: 1
  end
end
