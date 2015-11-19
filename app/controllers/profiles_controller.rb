class ProfilesController < ApplicationController
  before_filter :load_institution
  before_action :correct_editor,  only: [:edit]
  before_action :correct_updater, only: [:update]

  def edit
  end

  def update
    if @profile.update! profile_params
      success "Your profile was updated!"
      redirect_to @profile.user
    end
  rescue => e
    trigger_airbrake(e)
    danger "An unexpected error occurred when we tried to update your profile."
    redirect_to @profile.user
  end

  private

    def correct_editor
      username = params.fetch(:id) { raise }
      user = User.find_by(username: username)
      @profile = user.profile || user.create_profile

      unless current_user?(user)
        danger :only_owner_may_edit
        store_location
        redirect_to login_url
      end
    end

    def correct_updater
      username = params.fetch(:id) { raise }
      user = User.find_by(username: username)
      @profile = user.profile

      unless current_user?(user)
        danger :only_owner_may_edit
        store_location
        redirect_to login_url
      end
    end

    def profile_params
      params.require(:profile).permit(:organization, :position,
                                      :voice, :fax, :delivery,
                                      :city, :area, :zipcode,
                                      :country, :email,
                                      :website_url)
    end


end
