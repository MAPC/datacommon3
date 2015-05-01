namespace :db do
  desc "Convert current production data to new DataCommon"

  task convert: :environment do

    puts "Creating institutions"
    Institution.create_or_update( id:         1,
                                  short_name: 'Metro Boston',
                                  long_name:  'Metropolitan Boston',
                                  subdomain:  'metroboston' )

    Institution.create_or_update( id:         2,
                                  short_name: 'Central Mass',
                                  long_name:  'Cental Massachusetts',
                                  subdomain:  'centralmass')


    # puts "Activating topics except Geographic Boundaries"
    # IssueArea.unscoped.all.each {|t| t.update_attribute(:active, true) }
    # IssueArea.find(13).update_attribute(:active, false)


    # puts "Marking geographies as municipalities and subregions"
    # Geography.find_each do |place|
    #   type = place.regiontype_id == 5 ? 'subregion' : 'municipality'

    #   place.type = type
    #   place.save(validate: false)
    # end



    puts "Marking Dynamic Visualizations as municipalities and subregions"
    DynamicVisualization.find_each do |visual|
      type = visual.regiontype_id == 5 ? 'subregion' : 'municipality'

      visual.type = type
      visual.save(validate: false)
    end


    # cmrpc_places = %w(
    #   17 21 28 32 39 45 54 77 80 84 110 124 134 138 151 179 186 188 
    #   202 212 215 216 222 226 228 241 257 271 278 280 287 290 303 
    #   304 311 316 321 323 328 348 11 12 15 19 64 97 103 115 125 140 
    #   147 153 162 234 235 255 270 282 294 299 332 343
    # )
    
    # cmrpc_places.each do |id|
    #   place = Geography.find_by(unitid: id)
    #   place.institution_id = 2
    #   place.save(validate: false)
    # end


    # puts "Making all visualizations private first"
    # Visualization.unscoped.find_each do |visual|
    #   next if visual.permission == "private"
      
    #   visual.permission = "private"
    #   visual.save(validate: false)
    # end


    # puts "Setting public visualizations to public"
    # Visualization.unscoped.find_each do |visual|
    #   query = <<-ENDSQL
    #     SELECT COUNT(*)
    #     FROM core_genericobjectrolemapping
    #       WHERE role_id = 7 AND object_id = #{visual.id}
    #   ENDSQL
      
    #   result = ActiveRecord::Base.connection.execute(query)
    #   count  = result.map {|r| r['count']}.first.to_i

    #   visual.permission = "public" if count == 2
    #   if visual.save(validate: false)
    #     visual
    #   else
    #     puts "Error saving visual: #{visual.id}: #{visual.errors.full_messages.join(', ')}"
    #   end
    # end


    puts "Setting visualizations that belong to CMRPC"
    cmrpc_visuals = [
      2660,2652,2639,2623,2526,2667,2673,2674,2675,66,2550,2527,2664,
      2666,2671,2672,2676,2663,2662,2646,2681,2677,2658,2678,2679,2680
    ]

    Visualization.unscoped.find(cmrpc_visuals).each do |visual|
      visual.institution_id = 2
      visual.permission     = 'public'
      if visual.save(validate: false)
        visual
      else
        puts "Error saving CMRPC visual: #{visual.id}: #{visual.errors.full_messages.join(', ')}"
      end
    end


    puts "Setting featured visualizations"
    Visualization.unscoped.find(2403).update_attribute :featured, 1  # MAPC
    Visualization.unscoped.find(2673).update_attribute :featured, 1  # CMRPC


    puts "Updating visualizations with images"
    Visualization.unscoped.find_each do |visual|
      # Skip if it already has a filename
      next if visual.image_file_name.presence

      visual.image_file_name    = "#{visual.id}.png"
      visual.image_content_type = "image/png"
      begin
        visual.image_file_size    = open(visual.image.url) {|f| f.read }.size
      rescue
        puts "Error: Couldn't find file for visualization #{visual.id}"
        next
      end
      visual.image_updated_at   = Time.now

      if visual.save(validate: false)
        visual
      else
        puts "Error saving visualization #{visual.id}: #{visual.errors.full_messages.join(', ')}"
      end
    end


    # puts "Updating visualizations with missing images"
    # `CLASS=Visualization rake paperclip:refresh`


    puts "Updating static maps with images"
    StaticMap.find_each do |static_map|
      # Skip if it already has a filename
      next if static_map.map_file_name.presence
      
      static_map.map_file_name = static_map.pdf_page.partition('/').last
      begin
        static_map.map_file_size = open(static_map.map.url) {|f| f.read }.size
      rescue
        puts "Error: Couldn't find file for static_map #{static_map.id}"
        next
      end
      static_map.map_content_type = 'application/pdf'
      static_map.map_updated_at   = Time.now

      if static_map.save(validate: false)
        static_map
      else
        puts "Error saving static map: #{static_map.id}: #{static_map.errors.full_messages.join(', ')}"
      end
    end


    # puts "Updating static maps with missing images"
    # `CLASS=StaticMap rake paperclip:refresh`



    # Update profiles and user profiles with CMRPC
    # profiles = Profile.where(organization: 'CMRPC')
    # profiles = profiles + Profile.where(organization: 'Central Massachusetts Regional Planning Commission')

    # profiles.each do |profile|
    #   profile.user.visualizations.each {|v| v.update_attribute :institution_id, 2 }
    # end

    # user  = User.where(username: 'cjryan2006').profile
    # user2 = User.where(username: 'mfranz77').profile
    # user3 = User.where(username: 'edd06001').profile
    # [user, user2, user3].each do |user|
    #   user.visualizations.each {|v| v.update_attribute :institution_id, 2 }
    # end
    
  end
end