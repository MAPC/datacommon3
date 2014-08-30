class Profile

  attr_reader :user

  def initialize(user)
    @user = user
    @visualizations = user.visualizations
  end

  def method_missing(method_name, *args)
    @user.send(method_name)
  end

end