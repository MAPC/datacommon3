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
        flash[:html_safe] = true
        flash[:success] = "Welcome!"
        flash[:warning] = render_to_string(partial: "shared/activate_message", locals: {user: user})
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
