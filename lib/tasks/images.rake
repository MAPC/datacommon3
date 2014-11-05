# require 'watir'
require 'base64'
require 'fileutils'


namespace :vis do
  desc "Download all Weave visualizations as preview images"
  task :crawl => :environment do

    @b = Watir::Browser.new
    @b.goto 'centralmass.datacommon.dev'

    geographies = %w( Municipality Subregion )
    topics = IssueArea.all

    geographies.each do |geography_name|
      geography = Kernel.const_get geography_name
      puts "Crawling geography: #{geography_name}"

      geography.all.each do |area|
        topics.each do |topic|
          render_all_images_for(area, topic, geography_name)
        end
      end
    end

  end
end


private
  
  def render_all_images_for(area, topic, geography)
    url = "metroboston.datacommon.dev/#{geography.parameterize.pluralize}/#{area.slug}/#{topic.slug}"
    @b.goto "metroboston.datacommon.dev/#{geography.parameterize.pluralize}/#{area.slug}/#{topic.slug}"
    puts "went to #{url}"

    @b.execute_script <<-JS
      DC.establishAllBase64();
    JS

    puts "started establishing,  now sleeping..."

    sleep 45

    puts "awake!"

    @image_data = @b.execute_script <<-JS
      return DC.getAllBase64();
    JS

    puts "image data: #{@image_data.inspect}" 

    @image_data.each_pair do |index, img|
      png_spec = "data:image/png;base64,"
      data_url = "#{png_spec}#{img}"
      png      = Base64.decode64(data_url[png_spec.length..-1])
      filename = "#{Rails.public_path}/dynamic_visualizations/images/#{area.slug}/#{index}.png"

      dirname = File.dirname(filename) 
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

      puts "saving #{filename}..."

      File.open(filename, 'wb') { |f| f.write(png) }

      puts "\t\t\t...saved!"
    end
  end