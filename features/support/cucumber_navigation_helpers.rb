# Most of this code by Diaspora, http://github.com/diaspora/diaspora.git
# from features/support/paths.rb


module CucumberNavigationHelpers

  def path_to(page_name)
    case page_name
      when /^person_photos page$/
         person_photos_path(@me.person)
      when /^the home(?: )?page$/
        root_path
      when /^the institution page$/
        root_path
      when /^the map index page$/
        static_maps_path
      when /^its ([\w ]+) page$/
        send("#{$1.gsub(/\W+/, '_')}_path", @it)
      when /^the ([\w ]+) page$/
        send("#{$1.gsub(/\W+/, '_')}_path")
      when /^my edit profile page$/
        edit_profile_path
      when /^my profile page$/
        person_path(@me.person)
      when /^"([^\"]*)"'s page$/
        p = User.find_by(username: $1)
      when /^"([^\"]*)"'s photos page$/
        p = User.find_by_email($1).person
        person_photos_path p
      when /^my account settings page$/
        edit_user_path
      when /^forgot password page$/
          new_user_password_path
      when /^"(\/.*)"/
        $1
      else
        raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end

  def navigate_to(page_name)
    path = path_to(page_name)
    visit(path)
  end

  def confirm_on_page(page_name)
    current_path = URI.parse(current_url).path
    expect(current_path).to eq(path_to(page_name))
  end

end

World(CucumberNavigationHelpers)