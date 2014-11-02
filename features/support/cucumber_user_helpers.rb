# Most of this code by Diaspora, http://github.com/diaspora/diaspora.git
# from features/support/user_cuke_helpers.rb


module CucumberUserHelpers

  # use the @me user to perform a manual login via the sign_in page
  def manual_login
    visit signin_path
    login_as @me.username, @me.password
  end

  # fill out the fields on the sign_in page and press submit
  def login_as(user, pass)
    fill_in 'session[username]', with: user
    fill_in 'session[password]', with: pass
    click_link "Log in"
  end


  def confirm_login
    page.has_content?("#{@me.first_name} #{@me.last_name}")
  end


  # go to user menu, expand it, and click logout
  def manual_logout
    find("#user-menu li:first-child a").click
    find("#user-menu li:last-child a").click
  end
end

World(CucumberUserHelpers)
World(FactoryGirl::Syntax::Methods)