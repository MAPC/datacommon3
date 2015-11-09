require 'spec_helper'

feature 'User visits profile' do
  subject(:user) { create(:user, :active) }

  background do
    sign_in user
    visit user_path(user)
  end

  scenario 'sees information' do
    expect(page).to have_content(user.name)
    expect(page).to have_content('Edit Profile')
  end

  feature 'and edits profile' do
    background do
      click_link 'Edit Profile'
    end

    scenario 'with valid information' do
      info = {
       :Organization               => 'MAPC',
       :'Position at organization' => 'Web Developer',
       :'Phone number'             => '617-999-9999',
       :Address                    => '60 Temple Place',
       :City                       => 'Boston, MA',
       :Zipcode                    => '02111',
       :Country                    => 'USA',
       :'Email address'            => 'info@mapc.org',
       :'Your website URL'         => 'http://www.mapc.org/about-mapc/staff/' }
      info.each_pair do |field, value|
        fill_in field, with: value
      end
      click_button 'Update Profile'
      expect(page).to have_content(/updated/i)
      # save_and_open_page
      expect(page).to have_content('http://www.mapc.org/about-mapc/staff/')
    end

    scenario 'with invalid information' do
      pending 'invalid information'
    end
  end
end

feature 'Signed out user prevented from editing profile' do
  pending 'no button'
  pending 'rejected from navigating to /edit'
end
