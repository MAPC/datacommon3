require 'spec_helper'

feature 'User requests password reset' do
  
  before { 
    @user = create(:user)
    ActionMailer::Base.deliveries.clear
  }

  scenario 'with valid email' do
    request_password_reset_for(@user)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(page).to have_content(/sent an email/i)
  end

  scenario 'with the wrong email address' do
    request_password_reset_for(@user, email: 'the-wrong@em.ail')
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    expect(page).to have_content(/not found/i)
  end
end