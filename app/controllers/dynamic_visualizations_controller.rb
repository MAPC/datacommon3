class DynamicVisualizationsController < ApplicationController

  # PNG_SPEC = "data:image/png;base64,"


  private

    def make_directory_for(filename)
      dirname = File.dirname(filename)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end

end


