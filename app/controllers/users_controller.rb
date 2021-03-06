class UsersController < ApplicationController
  before_filter :load_institution

  before_filter :logged_out, only: [:new]
  # before_filter :correct_user,   only: [:edit, :update]
  # before_filter :logged_in_user, only: [:edit, :update]

  def show
    @user = User.find_by(username: params[:id])
    if @user.nil?
      # flash[:danger] = "No user with that username could be found."
      danger :no_user
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.institution = @institution.presence
    if @user.save
      sign_in @user
      success :welcome
      flash[:warning] = render_to_string(partial: "shared/activate_message", locals: {user: @user})
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(username: params[:id])
  end

  def update
    @user = User.find_by(username: params[:id])
    if @user.profile.update_attributes( profile_params )
      success :profile_updated
      redirect_to @user
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

  def resend_activation_email
    @user = User.find_by(username: params[:id])
    if @user.activated?
      warning :already_activated
      redirect_back_or @user
    end
    if @user.resend_activation_email
      success :resent_activation_email
      redirect_back_or @user
    end
  rescue
    warning :unexpected_error
    redirect_back_or @user
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
        danger "Please sign in."
        redirect_to login_url
      end
    end

    def logged_out
      if logged_in?
        danger "You are already logged in."
        redirect_to current_user
      end
    end

end
