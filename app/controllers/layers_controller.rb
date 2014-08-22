class LayersController < ApplicationController
  before_filter :load_institution

  def index
    @layers = Layer.all
    # @layers = Layer.institution(@institution)
  end

  def show
    @layer  = Layer.find params[:id]
  end
end
