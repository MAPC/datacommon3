class InstitutionsController < ApplicationController
  before_filter :load_institution
  
  def show
    @heros   = Hero.institution(@institution).limit(3)
    @feature = Visualization.where(institution_id: @institution.id).featured.sample

    if @feature.nil?
      @feature = Visualization.where(institution_id: @institution.id).sample
    end
  end
end
