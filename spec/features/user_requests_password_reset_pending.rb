require 'spec_helper'

feature 'User requests password reset' do
  scenario 'with valid email' do
    user = create(:user)
    expect { 
      request_password_reset_for(user)
    }.to change(ActionMailer::Base.deliveries.count).by(1)

    expect(page).to have_content('sent an email')
  end

  scenario 'with invalid email' do
    user = create(:user, email: 'invalid_email_address')
    expect { 
      request_password_reset_for(user)
    }.not_to change(ActionMailer::Base.deliveries.count)


    expect(page).to have_content('Sorry')
  end

  scenario 'with blank email' do
    user = create(:user, email: '')
    expect { 
      request_password_reset_for(user)
    }.not_to change(ActionMailer::Base.deliveries.count)

    expect(page).to have_content('Sorry')
  end
end