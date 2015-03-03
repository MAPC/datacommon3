require 'spec_helper'

feature 'Visitor filters static maps' do

  background do
    acs  = create(:data_source, name: "ACS")
    dph  = create(:data_source, name: "DPH")
    map1 = create(:map, data_sources: [acs])
    map2 = create(:map, data_sources: [dph])
  end

  scenario 'by data source' do
    visit static_maps_path
    filter_by :data_source, 'id'
    expect(page).to have_content(map1.title)
    expect(page).to_not have_content(map2.title)
  end

  pending 'by topic'

end
