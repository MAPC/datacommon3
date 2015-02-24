require 'spec_helper'

feature 'Visitor requests password reset' do
  scenario 'with valid email' do
    user = create(:user)
    request_password_reset_with user.email

    expect(page).to have_content('sent an email')
  end

  scenario 'with invalid email' do
    user = create(:user)
    request_password_reset_with 'invalid_email_address'

    expect(page).to have_content('Sorry')
  end

  scenario 'with blank email' do
    user = create(:user)
    request_password_reset_with ''

    expect(page).to have_content('Sorry')
  end
end