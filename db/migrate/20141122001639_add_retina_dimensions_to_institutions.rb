class AddRetinaDimensionsToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :retina_dimensions, :text
  end
end