class SessionsController < ApplicationController
  before_filter :load_institution

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      
      if user.inactive?
        message = "Welcome! We see you haven't activated your account yet. "
        message += "Please check your email for the activation link."
        flash[:warning] = message
      end
      
      redirect_back_or user
    else
      flash.now[:danger] = "Incorrect username and/or password."
      render 'new'
    end
  end

  def destroy
    store_location
    sign_out if signed_in?
    flash[:success] = "See you later!"
    redirect_back_or root_url
  end
end
