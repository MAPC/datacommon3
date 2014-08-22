class LayerCollection < ActiveResource::Collection
  
  attr_accessor :meta #, :next_page, :prev_page, :total_count, :limit

  def initialize(parsed = {})
    @elements  = parsed['objects']
    @meta      = parsed['meta']

    # @next_page    = @meta['next'].to_i
    # @prev_page    = @meta['previous'].to_i
    # @total_count  = @meta['total_count'].to_i
    # @limit        = @meta['limit'].to_i
  end
end