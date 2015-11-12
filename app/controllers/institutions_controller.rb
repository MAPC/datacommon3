class InstitutionsController < ApplicationController
  before_filter :load_institution

  def show
    @dashboard = OpenStruct.new
    @dashboard.heros    = @institution.heros.active
    @dashboard.feature  = @institution.featured_visualization
    @dashboard.datasets = []
  end

end
