namespace :layer do
  desc "Export a list of layers and their spatial extents."

  task export: :environment do

    results = {}
    Layer.find_each do |l|
      results[l.title.to_sym] = l.spatial_extents.map(&:title)
    end

    file = File.open("#{Time.now.to_i}-layer-export.txt", "w") do |file|
      results.each_pair do |k, v|
        file.puts k
        v.each { |e| file.puts "\t- #{e}" }
      end
    end

  end
end