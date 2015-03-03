module Features
  module NavigationHelpers

    def delete(path)
      Capybara.current_session.driver.delete path
    end
    
  end
end