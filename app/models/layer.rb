class Layer < ActiveResource::Base
  self.site = "http://66.181.92.20/api"
  self.include_format_in_path = false
  self.collection_parser = LayerCollection

  # this behavior is replicated in the
  # local copy of ActiveRecord  
  # self.suffix = '/'

  def owner_object
    User.find_by(id: (owner_id || owner.id))
  end

  alias_method :_owner, :owner_object


  def thumbnail_src
    "http://66.181.92.20/media/thumbs/layer-#{id}-thumb.png"
  end


  def name
    title.titleize
  end


  def to_s
    name
  end


end