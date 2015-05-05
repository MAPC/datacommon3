class UsersController < ApplicationController
  before_filter :load_institution
  
  before_filter :logged_out, only: [:new]
  # before_filter :correct_user,   only: [:edit, :update]
  # before_filter :logged_in_user, only: [:edit, :update]

  def show
    @user = User.find_by(username: params[:id])
    if @user.nil?
      flash[:danger] = "No user with that username could be found."
      redirect_to signup_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.new_account_followup_emails
      @user.create_profile(name:  @user.first_name + " " + @user.last_name,
                           email: @user.email)
      sign_in @user
      flash[:success] = "Welcome to the DataCommon!"
      redirect_to @user
    else
      render :new
    end
  end

  def check_email
    @user = User.find_by(email: check_params[:email])
    respond_to do |format|
      format.json { render json: !@user }
    end
  end

  def check_username
    @user = User.find_by(username: check_params[:username])
    respond_to do |format|
      format.json { render json: !@user }
    end
  end


  private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :username,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

    def check_params
      params.require(:user).permit(:email, :username)
    end



    def correct_user
      user = User.find_by(username: params[:id])

      if current_user?(user)
        visualizations = Visualization.unscoped.where(owner_id: user.id).page(params[:page])
      else
        visualizations = user.visualizations.page(params[:page])
      end

      @profile = ProfileFacade.new(user, user.profile, visualizations)
    end


    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please sign in."
        redirect_to login_url
      end
    end

    def logged_out
      if logged_in?
        flash[:danger] = "You are already logged in."
        redirect_to current_user
      end
    end

end
