class SearchController < ApplicationController
  before_filter :load_institution

  def search
    @results = Search.new(query: search_param).results#.page(params[:page])
  end

  def suggest
  end

  private

    def search_param
      params.require(:search)
    end
end