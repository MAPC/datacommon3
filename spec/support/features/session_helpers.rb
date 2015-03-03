module Features
  module SessionHelpers

    def sign_up_with(email, password)
      visit signup_path
      fill_in 'First name',    with: 'First'
      fill_in 'Last name',     with: 'Last'
      fill_in 'Email address', with: email
      fill_in 'Username',      with: 'firstlast'
      fill_in 'Password',      with: password
      fill_in 'Password confirmation', with: password
      click_button 'Sign up'
    end

    def sign_in(user, options={})
      visit signin_path
      fill_in 'Username',
        with: options.fetch(:username) { user.username }
      fill_in 'Password',
        with: options.fetch(:password) { user.password }
      checked = options.fetch(:remember_me) { '1' }
      if checked == '1'
        check 'Remember me' 
      elsif checked == 0
        uncheck 'Remember me'
      end
      click_button 'Sign in'
    end

    def sign_out(*)
      # Would prefer to visit signout_path, method: :delete
      # but can't find documentation on such an option
      click_link 'Sign out'
    end

    def request_password_reset_for(user, options={})
      visit new_password_reset_path
      fill_in 'Email', with: options.fetch(:email) { user.email }
      click_button 'Request password reset'
    end

    def set_password(options={})
      password = options.fetch(:password) { 'v4lidp4ssw0rd' }
      confirm  = options.fetch(:confirmation) { password }
      fill_in 'Password',              with: password
      fill_in 'Password confirmation', with: confirm
      click_button 'Update password'
    end

  end
end