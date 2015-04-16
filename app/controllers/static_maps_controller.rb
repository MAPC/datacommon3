class StaticMapsController < ApplicationController
  before_filter :load_institution

  has_scope :topic
  has_scope :data_source
  
  def index
    @maps = apply_scopes(
      StaticMap.institution(@institution)
    ).page(params[:page])
    # @maps = apply_scopes(StaticMap.page(params[:page]))
  end

  def show
    @map = StaticMap.find params[:id]
  end
end
