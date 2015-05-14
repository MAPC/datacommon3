module Features
  module NavigationHelpers

    def refresh_page
      visit current_path
    end

    def delete(path)
      Capybara.current_session.driver.delete path
    end
    
  end
end