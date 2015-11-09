require 'spec_helper'

feature 'Visitor signs up' do

  before { ActionMailer::Base.deliveries.clear }

  scenario 'with valid email and password' do
    expect{
      sign_up_with 'valid@example.com', 'password'
    }.to change{
      ActionMailer::Base.deliveries.size
    }.by(1)
    expect(page).to have_content('Sign out')
    expect(page).to have_content('First') # = First name of sample user
  end

  scenario 'with invalid email', js: true do
    sign_up_with 'invalid_email@', 'password'
    expect(page).to have_content('enter a valid email')
    expect(page).to have_content('Sign up')
  end

  scenario 'with blank password', js: true do
    sign_up_with 'valid@example.com', ''
    expect(page).to have_content("enter a pass")
    expect(page).to have_content('Sign up')
  end
end