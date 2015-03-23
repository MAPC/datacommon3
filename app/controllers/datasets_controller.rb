class DatasetsController < ApplicationController
  before_filter :load_institution

  def index
    @datasets = Dataset.page(params[:page])
  end

  def show
    @dataset = Dataset.find_by(id: params[:id]).first
    # TODO: Fix the model so we don't need #first
  end

  def download
  end

end