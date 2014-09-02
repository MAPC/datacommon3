class ProfileFacade

  attr_reader :user, :profile, :visualizations

  def initialize(user, profile, visualizations)
    @user           = user
    @profile        = profile
    @visualizations = visualizations
  end

  def has_rich_data?
    !@profile.nil?
  end

  def method_missing(method_name)
    if @profile
      @profile.send method_name
    else
      @user.send method_name
    end
  end

end