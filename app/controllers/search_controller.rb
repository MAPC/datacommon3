class SearchController < ApplicationController
  before_filter :load_institution

  def search
    search_param = params.fetch(:search) { "" }
    results  = Search.new(query: search_param).results
    queryset = Dataset.find_by(q:    search_param.gsub(' ', '+'))
    tagset   = Dataset.find_by(tags: search_param.gsub(' ', '+'))
    
    @datasets = [queryset.records, tagset.records].flatten
    @results  = SearchFacade.new(results)
  end

  def suggest
  end

end