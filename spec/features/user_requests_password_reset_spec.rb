require 'spec_helper'

feature 'User requests password reset' do
  scenario 'with valid email' do
    user = create(:user)
    request_password_reset_for user

    expect(page).to have_content('sent an email')
  end

  scenario 'with invalid email' do
    user = create(:user, email: 'invalid_email_address')
    request_password_reset_for user

    expect(page).to have_content('Sorry')
  end

  scenario 'with blank email' do
    user = create(:user, email: '')
    request_password_reset_for user

    expect(page).to have_content('Sorry')
  end
end