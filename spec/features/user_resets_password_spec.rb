require 'spec_helper'

feature 'User resets password' do

  subject(:user) { 
    user = create(:active_user)
    sign_in user
    user.reset_password!
    user
  }
  
  scenario 'with a valid token' do
    visit edit_password_reset_path(user.reset_token, email: user.email)
    expect(page).to have_content('Reset password')

    scenario 'with a valid password and confirmation' do
      set_password
      expect(page).to have_content('Password has been reset')
    end

    scenario 'with an invalid password and confirmation' do
      set_password confirmation: 'wrongpw'
      expect(page).to have_content('Reset password')
    end

    scenario 'with a blank password' do
      set_password password: ''
      expect(page).to have_content('Reset password')
    end
  end

  scenario 'with an expired token'
    # User.expire_reset_token
    # user.update_attribute(:reset_sent_at, 121.minutes.ago)
    #  set_password(confirmation: 'wrongpw')

  scenario 'with the wrong token' do
    visit edit_password_reset_path('FHQWGADS', email: user.email)
    expect(page).to have_content('Invalid token/email combination')
  end

  scenario 'with the wrong email' do
    visit edit_password_reset_path(user.reset_token, email: 'user.dot.email@email.com')
    expect(page).to have_content('Invalid token/email combination')
  end
end