class SessionsController < ApplicationController
  before_filter :load_institution

  def new
  end

  def create
    username, password = params[:session][:username], params[:session][:password]
    user = User.authenticate username, password
    if user
      sign_in user
      flash[:success] = "Welcome to the DataCommon!"
      redirect_to user
    else
      flash[:danger] = <<-EOS
        We don't know that username/password combination.
        You may have mistyped something, or have CAPS LOCK on.
      EOS

      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
