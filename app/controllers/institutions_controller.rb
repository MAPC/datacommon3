class InstitutionsController < ApplicationController
  # before_filter :load_institution
  
  def show
    @heros   =   [Naught.build {|b| b.black_hole}] # Hero.institution(@institution).limit(3)
    @feature =   [Naught.build {|b| b.black_hole}] # Visualization.where(institution_id: @institution.id).featured.sample

    if @feature.nil?
      @feature = [Naught.build {|b| b.black_hole}] # Visualization.where(institution_id: @institution.id).sample
    end
  end
end
