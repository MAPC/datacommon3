class Profile

  attr_reader :user, :visualizations

  def initialize(user, visualizations)
    @user           = user
    @visualizations = visualizations
  end

  def method_missing(method_name, *args)
    @user.send(method_name)
  end

end