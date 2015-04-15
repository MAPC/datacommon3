class DatasetsController < ApplicationController
  before_filter :load_institution

  def index
    @datasets = if params[:topic].present?
      rows = params[:per_page] || Dataset.per_page
      Dataset.find_by(tags: params[:topic], rows: rows)
    else
      Dataset.find_by(rows: 10)
    end
  end

  def show
    @dataset = Dataset.find_by(id: params[:id]).records.first
  end

  def download
  end

end