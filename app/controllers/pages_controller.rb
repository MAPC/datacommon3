class PagesController < ApplicationController
  before_filter :load_institution

  def show
    @page = @institution.pages.where(topic_id: params[:page_topic_id]).where(slug: params[:id]).first
  end
end