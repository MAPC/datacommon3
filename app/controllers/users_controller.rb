class UsersController < ApplicationController
  before_filter :load_institution
  before_filter :correct_user, only: [:show]


  def new
    @user = User.new
  end


  def create
    @user = User.new user_params # TODO: Make sure some new_password param is passed in
    @user.active      = true
    @user.date_joined = Time.now
    
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render :new
    end
  end


  def show
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

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
