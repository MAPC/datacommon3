class AddFileAttachmentToLayers < ActiveRecord::Migration
  def up
    add_attachment    :'metadata._geo_layers', :csv
  end

  def down
    remove_attachment :'metadata._geo_layers', :csv
  end
end
