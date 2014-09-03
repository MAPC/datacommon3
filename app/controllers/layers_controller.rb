class LayersController < ApplicationController
  before_filter :load_institution

  def index
    @layers = Layer.institution(@institution).page params[:page]
  end

  def show
    @layer  = Layer.find_by(tablename: params[:id])
  end
end
