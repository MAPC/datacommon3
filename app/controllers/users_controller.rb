class UsersController < ApplicationController
  before_filter :load_institution

  def show
    user    = User.find_by(username: params[:id])
    profile = user.profile
    visualizations = user.visualizations.all.page(params[:page] || 1)

    @profile = ProfileFacade.new(user, profile, visualizations)
  end
end
