class SearchController < ApplicationController
  before_filter :load_institution

  def search
    results  = Search.new(query: params[:search]).results
    queryset = Dataset.find_by(q: params[:search].gsub(' ', '+'))
    tagset   = Dataset.find_by(tags: params[:search].gsub(' ', '+'))
    
    @datasets = [queryset.records, tagset.records].flatten
    @results  = SearchFacade.new(results)
  end

  def suggest
  end

end