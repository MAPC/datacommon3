class AddPreviewImageToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :preview_image, :string
  end
end
