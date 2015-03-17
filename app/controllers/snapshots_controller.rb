class SnapshotsController < ApplicationController

  # /snapshots/:type
  # /snapshots/{municipality|subregion}
  def index
    # @geographies = Geography.where(type: params[:type])
    @geographies = Geography.all
  end

  # /snapshots/:type/:slug
  # /snapshots/municipality/{boston|cambridge}
  def show
    @geography = Geography.find_by(slug: params[:id])
  end

  # /snapshots/:type/:slug/:topic
  # /snapshots/municipality/boston/{economy|demographics}
  def detail
    @snapshot = SnapshotFacade.new(
      geography: params[:slug],
      topic:     params[:topic]
    )
  end
end