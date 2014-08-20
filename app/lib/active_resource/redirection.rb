module ActiveResource
  class Redirection < ConnectionError # :nodoc:
    def to_s
      response['Location'] ? "#{super} => #{response['Location']}" : super
    end

    def to_url
      response['Location']
    end

    def to_findable
      
    end
  end
end