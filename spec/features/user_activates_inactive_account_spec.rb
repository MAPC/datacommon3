require 'spec_helper'

feature 'User activates inactive account' do
  
  scenario 'with a valid token' do
    user = create(:new_user)
    visit edit_account_activation_path(user.activation_token, email: user.email)
    expect(user.activated?).to be_true
  end

  scenario 'with the wrong token' do
    user = create(:new_user)
    visit edit_account_activation_path('FHQWGADS', email: user.email)
    expect(user.activated?).to be_false
  end

  scenario 'with the wrong email' do
    user = create(:new_user)
    visit edit_account_activation_path(user.activation_token, email: 'le@wrong.eml')
    expect(user.activated?).to be_false
  end

end