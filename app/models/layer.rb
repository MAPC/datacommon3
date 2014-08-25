class Layer < ActiveResource::Base
  self.site = "http://66.181.92.20/api"
  self.include_format_in_path = false
  self.collection_parser = LayerCollection

  # this behavior is replicated in the
  # local copy of ActiveRecord  
  # self.suffix = '/'

  PAGINATES_PER = 10

  def self.page(page_number=1)
    limit, offset = PAGINATES_PER, (page_number * PAGINATES_PER)
    self.all(params: {limit: limit, offset: offset})
  end


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