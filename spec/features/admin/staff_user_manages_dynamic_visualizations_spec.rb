require 'spec_helper'

feature 'Staff can manage dynamic visualizations' do
  let!(:staff)       { create(:user, :staff) }
  let!(:institution) { build_stubbed(Institution) }

  background do
    Institution.stub(:find_by)    { institution    }
    institution.stub(:short_name) { "Metro Boston" }

    2.times { create(:dynamic_visual) }
    sign_in staff

    visit '/admin/dynamic_visualization'
  end

  scenario 'staff can see the list of visualizations' do
    %w( Title Year Topics Filename Updated ).each do |item|
      expect(page).to have_content(item)
    end
    expect(page).to have_selector('tbody tr', count: 2)
  end

  scenario "staff can view all dynamic visualizations" do
    visual = DynamicVisualization.first
    visit "/admin/dynamic_visualization/#{visual.id}"
    expect(page)
  end

  scenario "staff can edit no dynamic visualizations" do
    visual = DynamicVisualization.first
    visit "/admin/dynamic_visualization/#{visual.id}"
    expect(page).to_not have_link("Edit")
  end
end

feature 'admin can manage dynamic visualizations' do
  let!(:admin)       { create(:user, :admin) }
  let!(:institution) { build_stubbed(Institution) }

  background do
    Institution.stub(:find_by)    { institution    }
    institution.stub(:short_name) { "Metro Boston" }

    2.times { create(:dynamic_visual) }
    sign_in admin

    visit '/admin/dynamic_visualization'
  end

  scenario "admin can view all dynamic visualizations" do
    visual = DynamicVisualization.first
    visit "/admin/dynamic_visualization/#{visual.id}"
    expect(page)
  end

  scenario "admin can edit no dynamic visualizations" do
    visual = DynamicVisualization.first
    visit "/admin/dynamic_visualization/#{visual.id}"
    click_link   'Edit'
    fill_in      'Title', with: 'An edited title'
    click_button 'Save'
    expect(page).to have_content("Details for Dynamic visualization 'An edited title'")
  end
end