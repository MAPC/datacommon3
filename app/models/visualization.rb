class Visualization < ActiveRecord::Base
  self.establish_connection :datacommon
  self.table_name = 'weave_visualization'

  belongs_to :user, foreign_key: :owner_id

  default_scope { limit 10 }

  def base_image_path
    "http://metrobostondatacommon.org/site_media/weave_thumbnails/#{id}"
  end

  def gallery_image_path
    "#{base_image_path}_gallery.png"
  end

  def preview_image_path
    "#{base_image_path}_featured.png"
  end

  alias_method :owner, :user
end
