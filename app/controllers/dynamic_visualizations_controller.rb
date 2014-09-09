class DynamicVisualizationsController < ApplicationController

  PNG_SPEC = "data:image/png;base64,"

  
  def image
    @vis = DynamicVisualization.find params[:id]
    png_data = Base64.decode64 params[:data]

    # TODO: Ensure consistency of filename scheme and ensure
    # that simple params can render it. Shouldn't need an object
    # because we want to end up with either a string or a number,
    # or both.
    # TODO: Implement it so this
    filename = @vis.preview_path params[:slug]
    # returns this
    # filename = "#{Rails.public_path}/dynamic_visualizations/images/#{said-slug}/#{@vis.id}.png"

    make_directory_for(filename)

    File.open(filename, 'wb') do |f|
      f.write( Base64.decode64 png_data )
    end
  end


  private

    def make_directory_for(filename)
      dirname = File.dirname(filename)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end

end


