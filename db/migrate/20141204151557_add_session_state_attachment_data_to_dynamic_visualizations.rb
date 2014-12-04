class AddSessionStateAttachmentDataToDynamicVisualizations < ActiveRecord::Migration
  def up
    DynamicVisualization.all.order(:id).each do |v|
      puts "DynamicVisualization: #{v.id}"
      v.session_state_file_name    = v.read_attribute(:sessionstate).split('/').last
      puts "path: #{v.session_state.url}"
      v.session_state_file_size    = open(v.session_state.url)
      v.session_state_content_type = 'application/xml'
      v.session_state_updated_at   = Time.now
      v.save
    end
  end

  def down
    DynamicVisualization.all.each do |v|
      v.session_state_file_name    = nil
      v.session_state_file_size    = nil
      v.session_state_content_type = nil
      v.session_state_updated_at   = nil
      v.save
    end
  end
end
