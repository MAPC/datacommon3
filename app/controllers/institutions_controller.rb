class InstitutionsController < ApplicationController
  before_filter :load_institution
  
  def show
    @heros   = Hero.institution(@institution).limit(3)
    @feature = Visualization.institution(@institution).featured.sample
  end
end
