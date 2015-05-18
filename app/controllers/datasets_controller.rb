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
    @dataset = Dataset.find_by(id: params[:id]).records.first
    @spatial = Dataset.find_by(tags: 'spatial', rows: 1).records.first
  end

  def download
  end

end