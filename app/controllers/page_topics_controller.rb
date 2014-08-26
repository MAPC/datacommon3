class PageTopicsController < ApplicationController
  before_filter :load_institution

  def show
    @pages = @institution.pages.keep_if do |page|
      page.topic_id == params[:id]
    end
  end
end
