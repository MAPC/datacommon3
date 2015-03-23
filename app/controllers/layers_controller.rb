class LayersController < ApplicationController
  before_filter :load_institution

  def index
    @packages = Package.all
  end

  def show
    @package = Package.find(id: params[:id])
  end

  def download
  end

end