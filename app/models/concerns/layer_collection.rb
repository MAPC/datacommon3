class LayerCollection < ActiveResource::Collection
  attr_accessor :meta
  def initialize(parsed = {})
    @elements  = parsed['objects']
    @meta      = parsed['meta']
  end
end