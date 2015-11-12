require 'spec_helper'

feature 'User creates public visualization' do
  subject(:user) { create(:user) }

  background do
    create(:topic,       title: 'Demographics')
    create(:data_source, title: 'ACS')
    sign_in user
    visit '/visualizations/new'
  end

  scenario 'valid' do
    title = 'My Viz Title'
    fill_in 'Title',        with: title
    fill_in 'Year(s)',      with: '2009'
    fill_in 'Abstract',     with: 'Abstract ' * 20
    select  'Demographics', from: 'Topics'
    select  'ACS',          from: 'Data Sources'
    find(:xpath, "//input[@id='visualization_sessionstate']").set("xml" * 40)
    expect {
      click_button 'Create'
    }.to change(Visualization, :count).by(1)
    expect(page).to have_content(title)
    visit visualizations_path
    expect(page).to have_content(title)
    visit profile_path(user)
    expect(page).to have_content(title)
  end

  scenario 'invalid' do
    expect(page).to have_content(/sign out/i) # Signed in.
    expect {
      click_button 'Create'
    }.to_not change(Visualization, :count)
    # Page, here, is the JSON response. It should have validation
    # errors that include the word "can't".
    expect(page).to have_content(/can't/i)
  end
end

feature 'User creates private visualization' do
  subject(:user) { create(:user) }

  background do
    create(:topic,       title: 'Demographics')
    create(:data_source, title: 'ACS')
    sign_in user
    visit '/visualizations/new'
  end

  scenario 'valid' do
    fill_in 'Title',        with: 'My Private Visual'
    fill_in 'Year(s)',      with: '2009'
    fill_in 'Abstract',     with: 'Abstract ' * 20
    select  'Demographics', from: 'Topics'
    select  'ACS',          from: 'Data Sources'
    select  'Private',      from: 'Public or Private?'
    find(:xpath, "//input[@id='visualization_sessionstate']").set("xml" * 40)
    expect {
      click_button 'Create'
    }.to change(Visualization.unscoped, :count).by(1)
    expect(page).to have_content('My Private Visual')
    visit visualizations_path
    expect(page).to_not have_content('My Private Visual')
  end
end

feature 'User duplicates public visualization' do
  let(:visual) { create(:visualization, title: 'Base Title') }
  let(:new_title) { 'A Duplicate Title' }

  pending 'from existing' do
    visit visualization_path(visual)
    click_link 'Clone'
    expect(page).to have_content("Base Title (Copy)")
    fill_in 'Title', with: new_title
    click_button 'Save'
    visit visualizations_path
    expect(page).to have_content(new_title)
  end
end


feature 'User duplicates private visualization' do
end


feature "see a private visualization" do
  scenario "see my own private visualization" do
  end
  scenario "fail to see someone else's private visualization" do
  end
end


feature 'Visitor tries to create visualization' do
  subject(:user) { create(:user) }
  scenario 'and cannot' do
    visit new_visualization_path
    expect(page).to have_content(/please sign in/i)
    sign_in user
    expect(page).to have_content(/New Visualization/i)
  end
end
