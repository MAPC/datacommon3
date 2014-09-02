class UsersController < ApplicationController
  before_filter :load_institution

  def show
    user = User.find_by(id: params[:id])
    visualizations = user.visualizations.all.page(params[:page] || 1)
    @profile = ProfileFacade.new(user, visualizations)
  end
end
