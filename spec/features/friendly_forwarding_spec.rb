require 'spec_helper'

feature 'Friendly forwarding' do 
  
  subject(:user) { create(:user) }
  
  scenario 'active user logs in' do
    visit edit_profile_path(user)
    sign_in user
    expect(page).to have_content('Edit Profile')
  end

end