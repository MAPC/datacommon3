class UsersController < ApplicationController
  before_filter :load_institution
  before_filter :correct_user, only: [:show]


  def new
    @user = User.new
  end


  def create
    @user = User.new user_params
    if @user.save
      @user.create_profile(name:  @user.first_name + " " + @user.last_name,
                           email: @user.email)
      sign_in @user
      redirect_to @user
    else
      render :new
    end
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

      if current_user?(user)
        visualizations = Visualization.unscoped.where(owner_id: user.id).page(params[:page])
      else
        visualizations = user.visualizations.page(params[:page])
      end

      @profile = ProfileFacade.new(user, user.profile, visualizations)
    end

end
