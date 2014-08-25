class LayerCollection < ActiveResource::Collection
  
  attr_accessor :meta

  def initialize(parsed = {})
    @elements  = parsed['objects']
    @meta      = parsed['meta']

    Kaminari::PaginatableArray.new(
      @elements, { limit:       @meta['next'].to_i,
                   offset:      @meta['offset'].to_i,
                   total_count: @meta['total_count'].to_i } )
  end

  def current_page
    @meta['limit'] / @meta['offset']
  end

  def total_pages
    @meta['total_count'] / @meta['limit'].ceil
  end

  def limit_value
    @meta['limit']
  end


end