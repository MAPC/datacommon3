require 'spec_helper'

feature 'Staff can manage institutions' do
  let!(:staff) { create(:user, :staff, institution_id: 1) }
  
  background do
    create(:institution, id: 1, short_name: 'Metro Boston')
    create(:institution, id: 2, short_name: 'Central Mass')
    sign_in staff
    visit '/admin/institution'
  end

  scenario 'staff can see only their institution' do
    %w( Short Domain ID ).each {|item| expect(page).to have_content(item) }
    expect(page).to have_content('Metro Boston')
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario "staff can edit their own institution's heros" do
    visit "/admin/institution/1"
    click_link   'Edit'
    fill_in      'Subdomain', with: 'metbos'
    click_button 'Save'
    expect(page).to have_content("metbos")
  end

  scenario "staff cannot view or edit another institution's heros" do
    visit "/admin/institution/2"
    expect(page).to have_content("not authorized")
    visit "/admin/institution/2/edit"
    expect(page).to have_content("not authorized")
  end

  scenario "staff cannot destroy other's heros" do
    visit "/admin/institution/2/delete"
    expect(page).to have_content("not authorized")
  end
end

feature 'admin can manage heros' do
  let!(:admin) { create(:user, :admin, institution_id: 1) }

  background do
    create(:institution, id: 1, short_name: 'Metro Boston')
    create(:institution, id: 2, short_name: 'Central Mass')
    sign_in admin
    visit '/admin/institution'
  end

  scenario 'admin can see all institutions' do
    %w( Short Domain ID ).each {|item| expect(page).to have_content(item) }
    expect(page).to have_content('Metro Boston')
    expect(page).to have_content('Central Mass')
    expect(page).to have_selector('tbody tr', count: 2)
  end

  scenario "admin can edit their own institution's heros" do
    visit "/admin/institution/1"
    click_link   'Edit'
    fill_in      'Subdomain', with: 'metbos'
    click_button 'Save'
    expect(page).to have_content("metbos")
  end

  scenario "admin can view or edit another institution's heros" do
    visit "/admin/institution/2"
    expect(page).to have_content("Details for Institution")
    expect(page).to_not have_content("not authorized")
    visit "/admin/institution/2/edit"
    expect(page).to have_content("Edit Institution")
    expect(page).to_not have_content("not authorized")
  end

  scenario "admin can destroy other's heros" do
    visit "/admin/institution/2/delete"
    expect(page).to have_content("Delete Institution")
    expect(page).to_not have_content("not authorized")
  end
end