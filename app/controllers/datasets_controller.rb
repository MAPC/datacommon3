class DatasetsController < ApplicationController
  before_filter :load_institution

  def index
    @datasets = if params[:topic].present?
      rows = params[:per_page] || Dataset.per_page
      Dataset.find_by(tags: params[:topic], rows: rows)
    else
      Dataset.page(params[:page])
    end
  end

  def show
    # TODO: Fix the model so we don't need #first
    @dataset = Dataset.find_by(id: params[:id]).first
  end

  def download
  end

end