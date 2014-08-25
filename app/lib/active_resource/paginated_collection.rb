class PaginatedCollection < ActiveResource::Collection

  # Custom collection to handle pagination methods
  attr_accessor :paginatable_array

  def initialize(elements=[])
    @elements = elements
    setup_paginatable_array
  end


  def setup_paginatable_array
    @paginatable_array ||= begin
      response = ActiveResource::Base.connection.response rescue {}

      puts "response.inspect::"
      puts response.inspect

      options = {
        limit:       response["meta"]["Pagination-Limit"].to_i,
        offset:      response["meta"]["Pagination-Offset"].to_i,
        total_count: response["meta"]["Pagination-TotalCount"].to_i
      }

      Kaminari::PaginatableArray.new(elements, options)
    end
  end

  private

  # Delegate missing methods to `paginatable_array` first:
  # Kaminari might know how to respond to them.
  # e.g. current_page, total_count.
  def method_missing(method, *args, &block)
    if paginatable_array.respond_to?(method)
      paginatable_array.send(method)
    else
      super
    end
  end


end