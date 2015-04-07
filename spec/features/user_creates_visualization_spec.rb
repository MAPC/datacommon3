require 'spec_helper'

feature 'User creates visualization' do

  subject(:user) { create(:user) }

  background do
    create(:topic,       title: 'Demographics')
    create(:data_source, title: 'ACS')
    sign_in user
    visit '/visualizations/new'
  end

  scenario 'invalid from scratch' do
    # couldn't get js: true to work with signing in
    expect(page).not_to have_content(/please sign in/i)
    expect{
      click_button 'Create'
    }.to_not change(Visualization, :count)
    # page = the JSON response
    expect(page).to have_content(/can't/i)
  end

  scenario 'valid from scratch' do
    fill_in 'Title',        with: 'My Viz Title'
    fill_in 'Year(s)',      with: '2009'
    fill_in 'Abstract',     with: 'Abstract ' * 20
    select  'Demographics', from: 'Topics'
    select  'ACS',          from: 'Data Sources'
    find(:xpath, "//input[@id='visualization_sessionstate']").set("xml" * 40)

    expect{
      click_button 'Create'
    }.to change(Visualization, :count).by(1)

    expect(page).to have_content('My Viz Title')
    visit visualizations_path
    expect(page).to have_content('My Viz Title')
  end

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


feature 'Visitor tries to create visualization' do

  subject(:user) { create(:user) }

  scenario 'and cannot' do
    visit new_visualization_path
    expect(page).to have_content(/please sign in/i)
    sign_in user
    expect(page).to have_content(/New Visualization/i)
  end
end