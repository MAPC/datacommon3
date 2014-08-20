class Layer < ActiveResource::Base
  self.site = "http://66.181.92.20/api"
  self.include_format_in_path = false
  self.collection_parser = LayerCollection

  # this behavior is replicated in the
  # local copy of ActiveRecord
  
  # self.suffix = '/'

  # def self.all_by_subdomain
  #   # retrieve collection
  #   layers = self.all.sort_by {|l| l.owner_id }
  # end


  def name
    title.titleize
  end

  def thumbnail_src
    "http://66.181.92.20/media/thumbs/layer-#{id}-thumb.png"
  end


end