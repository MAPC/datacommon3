class AddLogoAttachmentToInstitution < ActiveRecord::Migration
  def up
    add_attachment :institutions, :logo
  end

  def down
    remove_attachment :institutions, :logo
  end
end
