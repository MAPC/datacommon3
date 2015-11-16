class InstitutionsController < ApplicationController
  before_filter :load_institution

  def show
    @dashboard = OpenStruct.new
    @dashboard.heros    = @institution.heros.active
    @dashboard.feature  = @institution.featured_visualization
    @dashboard.datasets = []
    @dashboard.recent_visuals = @institution.visualizations.recent(4)
  end

end
