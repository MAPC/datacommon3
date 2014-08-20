class Layer < ActiveResource::Base
  self.site = "http://66.181.92.20/api"
  self.include_format_in_path = false
  self.collection_parser = LayerCollection

  # class << self
  #   def find_with_slash(id)
  #     old_find("#{id}/")
  #   end

  #   def find_with_redirect(id)
  #     begin
  #       old_find(id)
  #     rescue ActiveResource::Redirection => err
  #       old_find()
  #     end
  #   end

  #   alias_method :old_find, :find
  #   alias_method :find,     :find_with_slash
  # end

end