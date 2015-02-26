class SessionsController < ApplicationController
  before_filter :load_institution

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      remember user
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
