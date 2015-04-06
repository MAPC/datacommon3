class ProfilesController < ApplicationController
  before_filter :load_institution
  before_action :correct_user, only: [:edit, :update]

  def edit
    render 'users/edit'
  end


  def update
    @profile.update! profile_params
    redirect_to @profile.user
  end


  private

    ONLY_OWNER_MAY_EDIT = <<-EOE
      A user may only edit their own profile. If you were trying to
      edit your own profile, please sign in first.
    EOE


    def correct_user
      
      user = User.find_by(username: params[:id])
      @profile = user.profile || Profile.find_or_create_by(id: params[:id])

      unless current_user?(user)
        flash[:danger] = ONLY_OWNER_MAY_EDIT
        store_location
        redirect_to login_url
      end
    end


    def profile_params
      params.require(:profile).permit(:organization,
                                      :position,
                                      :voice,
                                      :delivery,
                                      :city,
                                      :area,
                                      :zipcode,
                                      :country,
                                      :email,
                                      :website_url  )
    end


end
