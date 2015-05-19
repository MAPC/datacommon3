class SetDefaultContentType < ActiveRecord::Migration
  def up
    change_column_default :mbdc_hero, :content_markup_type, 'html'
  end

  def down
    change_column_default :mbdc_hero, :content_markup_type, nil
  end
end
