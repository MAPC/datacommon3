class UsersController < ApplicationController
  before_filter :load_institution

  def show
    @profile = Profile.new User.find_by(id: params[:id])
  end
end
