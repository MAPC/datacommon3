require 'spec_helper'

feature 'Visitor views main page' do

  before do
    institution = create :institution, short_name: "Metroid Boston", id: 1
    create :topic, title: "Demographics"
    create :topic, title: "Civic Vitality & Governance"
    create :hero, :active, title: "Welcome to the DataCommon"
    2.times { create :hero, :active }
    visit institution_path(institution)
  end

  scenario 'shows institution' do
    expect(page).to have_content("Metroid Boston")
  end

  scenario 'shows heros' do
    heros = all '#heros .hero'
    expect(heros).to_not be_empty
    expect(heros).to have(3).items
  end

  scenario 'has one .active hero' do
    heros = all '#heros .hero .active'
    expect(heros).to_not be_empty
    expect(heros).to have(1).item
  end

  scenario 'shows only active heros' do
    create :hero, :inactive, title: "Such Inactivity, Wow"
    refresh_page
    expect(all '#heros .hero').to have(3).items
  end

  scenario 'shows new active heros' do
    create :hero, :active
    refresh_page
    expect(all '#heros .hero').to have(4).items
  end

  scenario 'shows hero content' do
    heros = find '#heros'
    expect(heros).to have_content("Welcome to the DataCommon")
    expect(heros).to have_content("Hero Saves Day")
  end

  scenario 'shows topics list' do
    expect(all '.icon').to_not be_empty
    expect(all '.demographics').to_not be_empty
    expect(page).to have_content(/Civic Vitality/i)
  end

end