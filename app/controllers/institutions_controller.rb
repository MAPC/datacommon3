class InstitutionsController < ApplicationController
  before_filter :load_institution
  
  def show
    @heros   = Hero.all
    @feature = Visualization.featured.sample
  end
end
