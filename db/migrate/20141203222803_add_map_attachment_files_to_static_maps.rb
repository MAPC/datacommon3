class AddMapAttachmentFilesToStaticMaps < ActiveRecord::Migration
  
  disable_ddl_transaction!

  def up
    StaticMap.find_each do |static_map|
      static_map.map_file_name    = static_map.pdf_page.partition('/').last
      static_map.map_file_size    = open(static_map.map.url) {|f| f.read}.size
      static_map.map_content_type = 'application/pdf'
      static_map.map_updated_at   = Time.now
      static_map.save
    end
  end

  def down
    StaticMap.find_each do |static_map|
      static_map.map_file_name    = nil
      static_map.map_file_size    = nil
      static_map.map_content_type = nil
      static_map.map_updated_at   = nil
      static_map.save
    end
  end
end

# After UP, run: 
# CLASS=StaticMap rake paperclip:refresh:thumbnails