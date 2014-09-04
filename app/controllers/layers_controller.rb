class LayersController < ApplicationController
  before_filter :load_institution

  def index
    @layers = Layer.all.page params[:page] #institution(@institution)
  end

  def show
    @layer  = Layer.find_by(tablename: params[:id])
  end
end
