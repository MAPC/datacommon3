class AddMapAttachmentToStaticMaps < ActiveRecord::Migration
  def up
    add_attachment :mbdc_calendar, :map
  end

  def down
    remove_attachment :mbdc_calendar, :map
  end
end
