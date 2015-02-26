class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    puts "email: #{params[:email]}"
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      puts "user activatable"
      user.update_attribute(:is_active,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      sign_in user
      flash[:success] = "Account activated! Welcome!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
