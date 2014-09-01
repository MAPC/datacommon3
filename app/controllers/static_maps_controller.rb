class StaticMapsController < ApplicationController
  before_filter :load_institution
  
  def index
    @maps = StaticMap.institution(@institution).page params[:page]
  end

  def show
    @map = StaticMap.find params[:id]
  end
end
