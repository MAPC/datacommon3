module CKANUpload
  class Login
    include Capybara::DSL

    def initialize
      @username = ENV.fetch('CKAN_UPLOAD_USERNAME')
      @password = ENV.fetch('CKAN_UPLOAD_PASSWORD')
    end

    def perform
      start_form ; fill_in_fields ; submit
    end

    def start_form
      visit "#{CKANUpload::DEFAULT_BASE_URL}/user/login"
    end

    def fill_in_fields
      fill_in 'Username', with: @username
      fill_in 'Password', with: @password
    end

    def submit
      click_button 'Login'
    end
  end
end