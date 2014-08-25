class LayersController < ApplicationController
  before_filter :load_institution

  def index
    @layers = Layer.page( params[:page] || 1 )
    # @layers = Layer.institution(@institution)
  end

  def show
    @layer  = Layer.find params[:id]
  end
end
