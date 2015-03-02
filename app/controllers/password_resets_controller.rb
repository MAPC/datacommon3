class PasswordResetsController < ApplicationController

  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.reset_password!
      flash[:info] = "Sent an email with password reset instructions."
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found."
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      @user.update_attribute(:reset_token, nil)
      sign_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user)
            .permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      # TODO so many code smells to clean up
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        flash[:danger] = "Invalid token/email combination."
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired"
        redirect_to new_password_reset_url
      end
    end
end
