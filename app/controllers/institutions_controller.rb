class InstitutionsController < ApplicationController
  before_filter :load_institution
  
  def show
    @heros   = Hero.institution(@institution).limit(3)
    @feature = Visualization.featured.sample
  end
end
