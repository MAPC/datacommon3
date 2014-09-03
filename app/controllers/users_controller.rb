class UsersController < ApplicationController
  before_filter :load_institution
  before_filter :correct_user, only: [:show]

  def show
  end

  private

    def correct_user
      user    = User.find_by(username: params[:id])
      profile = user.profile

      if current_user?(user)
        visualizations = Visualization.unscoped.where(owner_id: user.id).page(params[:page])
      else
        visualizations = user.visualizations.page(params[:page])
      end

      @profile = ProfileFacade.new(user, profile, visualizations)
    end

end
