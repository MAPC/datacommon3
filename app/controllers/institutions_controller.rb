class InstitutionsController < ApplicationController
  before_filter :load_institution
  
  def show
    @heros = Hero.all
  end
end
