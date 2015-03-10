require 'spec_helper'

feature 'Staff can manage heros' do
  let!(:staff) { create(:user, :staff, institution_id: 1) }
  let!(:institution) { build_stubbed(Institution) }

  background do
    Institution.stub(:find_by) { institution }
    institution.stub(:short_name) { "Metro Boston" }

    1.times { create(:hero, institution_id: 1) }
    2.times { create(:hero, institution_id: 2) }
    sign_in staff

    visit '/admin/hero'
  end

  scenario 'staff can see the list of heros' do
    %w( Title Order Active Institution ).each {|item| expect(page).to have_content(item) }
    expect(page).to have_content('Metro Boston')
    expect(page).to have_selector('tbody tr.hero_row', count: 1)
  end

  scenario "staff can edit their own institution's heros" do
    hero = Hero.find_by(institution_id: staff.institution_id)
    visit "/admin/hero/#{hero.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'An edited title'
    click_button 'Save'
    expect(page).to have_content("Details for Hero 'An edited title'")
  end


  let!(:hero) { Hero.find_by(institution_id: 2) }

  scenario "staff cannot view or edit another institution's heros" do
    visit "/admin/hero/#{hero.id}"
    expect(page).to have_content("not authorized")
    visit "/admin/hero/#{hero.id}/edit"
    expect(page).to have_content("not authorized")
  end

  scenario "staff cannot destroy other's heros" do
    visit "/admin/hero/#{hero.id}/delete"
    expect(page).to have_content("not authorized")
  end
end

feature 'admin can manage heros' do
  let!(:admin) { create(:user, :admin, institution_id: 1) }

  background do
    2.times { create(:hero, institution_id: 1) }
    1.times { create(:hero, institution_id: 2) }
    sign_in admin

    visit '/admin/hero'
  end

  scenario 'admin can see the list of heros' do
    %w( Title Order Active Institution ).each {|item| expect(page).to have_content(item) }
    expect(page).to have_selector('tbody tr.hero_row', count: 3)
  end

  scenario "admin can edit their own institution's heros" do
    hero = Hero.find_by(institution_id: admin.institution_id)
    visit "/admin/hero/#{hero.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'An edited title'
    click_button 'Save'
    expect(page).to have_content("Details for Hero 'An edited title'")
  end

  let!(:hero) { Hero.find_by(institution_id: 2) }

  scenario "admin can edit another institution's heros" do
    visit "/admin/hero/#{hero.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'A well-written title'
    click_button 'Save'
    expect(page).to have_content("Details for Hero 'A well-written title'")
  end

  scenario "admin can destroy any heros" do
    visit "/admin/hero/#{hero.id}/delete"
    expect(page).to_not have_content("not authorized")
    click_button "Yes, I'm sure"
    expect(page).to have_content("Heros")
  end
end