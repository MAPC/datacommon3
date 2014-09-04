class PageTopicsController < ApplicationController
  before_filter :load_institution

  def show
    @pages = @institution.pages.where(topic_id: params[:id])
  end
end
