module Features
  module FormHelpers

    def filter_by(name_or_id, option)
      select option, from: name_or_id
    end
    
  end
end