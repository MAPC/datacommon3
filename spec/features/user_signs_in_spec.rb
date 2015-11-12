require 'spec_helper'

feature 'Active user signs in' do

  let(:user) { create(:user) }

  scenario 'with valid information' do
    sign_in user
    expect(page).to have_content(user.first_name)
  end

  scenario 'with wrong username' do
    sign_in user, username: "wrong_username"
    expect(page).to_not have_content(user.first_name)
    expect(page).to have_content("Log in")
    expect(page).to have_content("Incorrect")
    visit root_path
    expect(page).not_to have_content("Incorrect")
  end

  scenario 'with wrong password' do
    sign_in user, password: "wrong_password"
    expect(page).to_not have_content(user.first_name)
    expect(page).to have_content("Log in")
  end

end

feature 'Active user signs in and out' do
  let(:user) { create(:user) }

  scenario 'with valid information' do
    sign_in user
    expect(page).to have_content(user.first_name)
    sign_out user
    expect(page).to have_content("Log in")
    delete signout_path
    expect(page).to have_content("Log in")
  end
end

feature 'Inactive user signs in' do

  let(:user) { create(:user, :inactive) }

  scenario 'with valid information and resends activation email' do
    sign_in user
    expect(page).to have_content(user.first_name)
    expect(page).to have_content("activate")
    expect(page).to have_content("resend")
    click_link 'resend'
    expect(page).to have_content(/check your email/i)
    # Default link should not be to profile
    expect(page).to_not have_content("/users/#{user.username}")
  end
end
