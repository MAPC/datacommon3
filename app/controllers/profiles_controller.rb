class ProfilesController < ApplicationController
  before_filter :load_institution
  before_action :correct_editor,  only: [:edit]
  before_action :correct_updater, only: [:update]

  def edit
  end

  def update
    if @profile.update! profile_params
      flash[:success] = "Your profile was updated!"
      redirect_to @profile.user
    end
  end

  private

    ONLY_OWNER_MAY_EDIT = <<-EOE
      A user may only edit their own profile. If you were trying to
      edit your own profile, please sign in first.
    EOE

    def correct_editor
      user = User.find_by(username: params[:id])
      @profile = user.profile || Profile.find_or_create_by(id: params[:id])

      unless current_user?(user)
        flash[:danger] = ONLY_OWNER_MAY_EDIT
        store_location
        redirect_to login_url
      end
    end

    def correct_updater
      @profile = Profile.find_by(id: params[:id])
      user = @profile.user

      unless current_user?(user)
        flash[:danger] = ONLY_OWNER_MAY_EDIT
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
