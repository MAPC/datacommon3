class StaticMapsController < ApplicationController
  before_filter :load_institution
  
  def index
    @maps = StaticMap.all.page params[:page]
    # @maps = StaticMap.institution(@institution).page params[:page]
  end

  def show
    @map = StaticMap.find params[:id]
  end
end
