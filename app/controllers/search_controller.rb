class SearchController < ApplicationController
  before_filter :load_institution

  def search
    results  = Search.new(query: search_param).results.compact#.page(params[:page])
    @results = SearchFacade.new(results)
  end

  def suggest
  end

  private

    def search_param
      params.require(:search)
    end
end