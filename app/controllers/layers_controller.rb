class LayersController < ApplicationController
  def index
    @layers = Layer.all
  end

  def show
    @layer  = Layer.find params[:id]
  end
end
