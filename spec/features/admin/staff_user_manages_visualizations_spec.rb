require 'spec_helper'

feature 'Staff can manage visualizations' do
  let!(:staff) { create(:user, :staff, institution_id: 1) }
  let!(:institution) { build_stubbed(Institution) }

  background do
    Institution.stub(:find_by) { institution }
    institution.stub(:short_name) { "Metro Boston" }
    institution.stub(:logo) { Naught.build { |b| b.black_hole }.new }

    1.times { create(:visualization, institution_id: 1) }
    2.times { create(:visualization, institution_id: 2) }
    sign_in staff

    visit '/admin/visualization'
  end

  scenario 'staff can see the list of visualizations' do
    visit '/admin/visualization'
    %w( Title Abstract Owner Institution ).each {|item|
      expect(page).to have_content(item)
    }
    expect(page).to have_content('Metro Boston')
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario "staff can edit their own institution's visualizations" do
    visualization = Visualization.find_by(institution_id: staff.institution_id)
    visit "/admin/visualization/#{visualization.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'An edited title'
    click_button 'Save'
    expect(page).to have_content("Details for Visualization 'An edited title'")
  end


  let!(:visualization) { Visualization.find_by(institution_id: 2) }

  scenario "staff cannot view or edit another institution's visualizations" do
    visit "/admin/visualization/#{visualization.id}"
    expect(page).to have_content("not authorized")
    visit "/admin/visualization/#{visualization.id}/edit"
    expect(page).to have_content("not authorized")
  end

  scenario "staff cannot destroy other's visualizations" do
    visit "/admin/visualization/#{visualization.id}/delete"
    expect(page).to have_content("not authorized")
  end
end

feature 'admin can manage visualizations' do
  let!(:admin) { create(:user, :admin, institution_id: 1) }

  background do
    2.times { create(:visualization, institution_id: 1) }
    1.times { create(:visualization, institution_id: 2) }
    sign_in admin

    visit '/admin/visualization'
  end

  scenario 'admin can see the list of visualizations' do
    %w( Title Abstract Owner Institution ).each do |item|
      expect(page).to have_content(item)
    end
    expect(page).to have_selector('tbody tr', count: 3)
  end

  scenario "admin can edit their own institution's visualizations" do
    visualization = Visualization.find_by(institution_id: admin.institution_id)
    visit "/admin/visualization/#{visualization.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'An edited title'
    click_button 'Save'
    expect(page).to have_content("Details for Visualization 'An edited title'")
  end

  let!(:visualization) { Visualization.find_by(institution_id: 2) }

  scenario "admin can edit another institution's visualizations" do
    visit "/admin/visualization/#{visualization.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'A well-written title'
    click_button 'Save'
    expect(page).to have_content("Details for Visualization 'A well-written title'")
  end

  scenario "admin can destroy any visualizations" do
    visit "/admin/visualization/#{visualization.id}/delete"
    expect(page).to_not have_content("not authorized")
    click_button "Yes, I'm sure"
    expect(page).to have_content("visualizations")
  end
end