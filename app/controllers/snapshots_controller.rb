class SnapshotsController < ApplicationController

  def index
  end

  # /snapshots/:slug
  # /snapshots/{boston|cambridge}
  def show
    @geography = Geography.find_by(slug: params[:id])
  end

  # /snapshots/:slug/:topic
  # /snapshots/boston/{economy|demographics}
  def detail
    @snapshot = SnapshotFacade.new(
      geography: params[:snapshot_id],
      topic:     params[:id]
    )
  end
end