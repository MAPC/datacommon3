class AddImageDataToVisualizations < ActiveRecord::Migration
  def up
    Visualization.all.each do |v|
      puts "Visualization: #{v.id}"
      v.image_file_name    = "#{v.id}.png"
      v.image_content_type = "image/png"
      v.image_file_size    = open(v.image.url) { |f| f.read }.size
      v.image_updated_at   = Time.now
      if !v.valid? && v.errors
        puts "v-------------- ERRORS (##{v.id}) --------------v"
        puts "  #{v.errors.full_messages}"
        puts "^-----------------------------------------------^"
        next
      end
      v.save
      v.reload
    end
  end
end
