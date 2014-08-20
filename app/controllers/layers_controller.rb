class LayersController < ApplicationController
  before_filter :load_institution

  def index
    # @layers = Layer.order(@institution)
    @layers = Layer.all
  end

  def show
    @layer  = Layer.find params[:id]
  end
end
