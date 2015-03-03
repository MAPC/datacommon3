class AddImageAttachmentToHero < ActiveRecord::Migration
  def up
    change_column_null :mbdc_hero, :image, true
    add_attachment     :mbdc_hero, :image
  end

  def down
    change_column_null :mbdc_hero, :image, false
    remove_attachment  :mbdc_hero, :image
  end
end
