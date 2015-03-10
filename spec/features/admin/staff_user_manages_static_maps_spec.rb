require 'spec_helper'

feature 'Staff can manage maps' do
  let!(:staff) { create(:user, :staff, institution_id: 1) }
  let!(:institution) { build_stubbed(Institution) }

  background do
    Institution.stub(:find_by) { institution }
    institution.stub(:short_name) { "Metro Boston" }

    1.times { create(:map, institution_id: 1) }
    2.times { create(:map, institution_id: 2) }
    sign_in staff

    visit '/admin/static_map'
  end

  scenario 'staff can see the list of maps' do
    %w( Title Date Abstract Institution ).each {|item| expect(page).to have_content(item) }
    expect(page).to have_content('Metro Boston')
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario "staff can edit their own institution's maps" do
    map = StaticMap.find_by(institution_id: staff.institution_id)
    visit "/admin/static_map/#{map.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'An edited title'
    click_button 'Save'
    expect(page).to have_content("Details for Static map 'An edited title'")
  end


  let!(:map) { StaticMap.find_by(institution_id: 2) }

  scenario "staff cannot view or edit another institution's maps" do
    visit "/admin/static_map/#{map.id}"
    expect(page).to have_content("not authorized")
    visit "/admin/static_map/#{map.id}/edit"
    expect(page).to have_content("not authorized")
  end

  scenario "staff cannot destroy other's maps" do
    visit "/admin/static_map/#{map.id}/delete"
    expect(page).to have_content("not authorized")
  end
end


require 'spec_helper'

feature 'admin can manage maps' do
  let!(:admin) { create(:user, :admin, institution_id: 1) }

  background do
    2.times { create(:map, institution_id: 1) }
    1.times { create(:map, institution_id: 2) }
    sign_in admin

    visit '/admin/static_map'
  end

  scenario 'admin can see the list of maps' do
    %w( Title Date Abstract Institution ).each {|item| expect(page).to have_content(item) }
    expect(page).to have_selector('tbody tr', count: 3)
  end

  scenario "admin can edit their own institution's maps" do
    map = StaticMap.find_by(institution_id: admin.institution_id)
    visit "/admin/static_map/#{map.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'An edited title'
    click_button 'Save'
    expect(page).to have_content("Details for Static map 'An edited title'")
  end

  let!(:map) { StaticMap.find_by(institution_id: 2) }

  scenario "admin can edit another institution's maps" do
    visit "/admin/static_map/#{map.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'A well-written title'
    click_button 'Save'
    expect(page).to have_content("Details for Static map 'A well-written title'")
  end

  scenario "admin can destroy any maps" do
    visit "/admin/static_map/#{map.id}/delete"
    expect(page).to_not have_content("not authorized")
    click_button "Yes, I'm sure"
    expect(page).to have_content("maps")
  end
end