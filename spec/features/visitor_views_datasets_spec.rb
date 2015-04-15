require 'spec_helper'

feature 'Visitor views datasets', :vcr do

  before do
    visit datasets_path
  end

  let(:links) { all '#datasets .dataset a' }

  scenario 'shows all datasets' do
    expect(links).to_not be_empty
    links.each do |link| 
      expect(link[:href]).to match(/\/datasets\/[0-9a-f\-]+/)
    end
  end

  pending 'shows a single dataset' do
    visit links.first[:href]
    expect(page).to have_content(/< DATA/i)
    expect(page).to have_content(/Last Updated/i)
  end

end