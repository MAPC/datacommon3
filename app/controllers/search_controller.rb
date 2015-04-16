class SearchController < ApplicationController
  before_filter :load_institution

  def search
    results  = Search.new(query: params[:search]).results
    @results = SearchFacade.new(results)
  end

  def suggest
  end

end