class DynamicVisualizationsController < ApplicationController

  PNG_SPEC = "data:image/png;base64,"

  # def image
  #   puts "#image"
  #   params[:data]
  #   # @vis = DynamicVisualization.find params[:id]

  #   # png_data = Base64.decode64 params[:data]
  #   # filename = "#{Rails.public_path}/dynamic_visualizations/images/#{params[:slug]}/#{params[:id]}.png"

  #   # make_directory_for(filename)

  #   # File.open(filename, 'wb') do |f|
  #   #   f.write( Base64.decode64 png_data )
  #   # end
  # end


  private

    def make_directory_for(filename)
      dirname = File.dirname(filename)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end

end


