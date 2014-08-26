class PagesController < ApplicationController
  before_filter :load_institution

  def show
    pages = @institution.pages.keep_if do |page|
      page.topic_id == params[:page_topic_id]
    end

    @page = pages.find {|page| page.slug == params[:id]}
  end
end