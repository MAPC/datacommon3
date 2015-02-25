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
      click_button 'Sign in'
    end

    def request_password_reset_for(user)
      visit password_reset_path
      fill_in 'Email', with: user.email
      click_button 'Request password reset'
    end

  end
end