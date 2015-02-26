class SessionsController < ApplicationController
  before_filter :load_institution

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      message = "You haven't activated your account yet. "
      message += "Check your email for the activation link."
      flash[:warning] = message
      redirect_to user
      # redirect_back_or user
    else
      flash.now[:danger] = "Incorrect username and/or password."
      render 'new'
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_url
  end
end
