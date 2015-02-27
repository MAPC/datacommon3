require 'spec_helper'

feature 'User activates inactive account' do

  subject(:user) { create(:inactive_user) }
  
  scenario 'with a valid token' do
    visit edit_account_activation_path(user.activation_token, email: user.email)
    expect(user.reload.activated?).to be_true
  end

  scenario 'with the wrong token' do
    visit edit_account_activation_path('FHQWGADS', email: user.email)
    expect(user.reload.activated?).to be_false
  end

  scenario 'with the wrong email' do
    visit edit_account_activation_path(user.activation_token, email: 'le@wrong.eml')
    expect(user.reload.activated?).to be_false
  end

end