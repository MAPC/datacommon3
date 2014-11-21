class AddImageDataToVisualizations < ActiveRecord::Migration
  def up
    Visualization.all.each do |v|
      v.image_file_name = "#{v.id}.png"
      v.image_content_type = "image/png"
      v.valid?
      puts v.errors.full_messages if v.errors
      v.save
      v.reload
      puts "\n\nVIS: #{v.inspect} #{v.id}"
      puts "IMAGE PATH: #{v.image.path}\n\n"
      v.image_file_size = File.open(v.image.path).size
      v.image_updated_at = Time.now
      v.save
      v.reload
      puts "\n\nVIS: #{v.inspect}\n\n"
    end
  end
end
