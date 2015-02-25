require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'
    expect(page).to have_content('Sign out')
    expect(page).to have_content('First') # = First name of sample user
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email@', 'password'
    expect(page).to have_content('Sign up')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''
    expect(page).to have_content('Sign up')
  end
end