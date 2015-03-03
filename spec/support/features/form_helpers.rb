module Features
  module FormHelpers

    def filter_by(name, option)
      select option, from: name
    end
    
  end
end