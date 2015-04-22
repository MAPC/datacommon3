class AccountActivationsController < ApplicationController
  before_filter :load_institution

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate!
      sign_in user
      flash[:success] = "Account activated! Welcome!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
