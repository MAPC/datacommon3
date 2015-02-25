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
    expect(page).to have_content("Sign in")
  end

  scenario 'with wrong password' do
    sign_in user, password: "wrong_password"
    expect(page).to_not have_content(user.first_name)
    expect(page).to have_content("Sign in")
  end

end