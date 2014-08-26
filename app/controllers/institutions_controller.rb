class InstitutionsController < ApplicationController
  before_filter :load_institution
  
  def show
    @hero = Hero.random
  end
end
