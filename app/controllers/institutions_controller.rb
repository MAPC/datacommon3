class InstitutionsController < ApplicationController
  # before_filter :load_institution

  def show
    
    # TODO: 
    # On the institution home (show) page, access
    #
    # @dashboard.news     -> news posts (mode: Hero)
    # @dashboard.feature  -> featured visualization
    # @dashboard.datasets -> most recent datasets
    # @dashboard = InstitutionDashboard.new(Institution.find_by(id: id))

    @heros   =   [Naught.build {|b| b.black_hole}] # Hero.institution(@institution).limit(3) # TODO: Unset limit here, set in volidations
    @feature =   [Naught.build {|b| b.black_hole}] # institution.featured_visualization
    
    if @feature.nil?
      @feature = [Naught.build {|b| b.black_hole}] # Visualization.where(institution_id: @institution.id).sample
    end
  end

end
