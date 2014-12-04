class AddSessionStateAttachmentToDynamicVisualizations < ActiveRecord::Migration
  def up
    add_attachment :snapshots_visualization, :session_state
  end

  def down
    remove_attachment :snapshots_visualization, :session_state
  end
end
