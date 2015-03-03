require 'spec_helper'

feature 'Visitor filters static maps' do

  scenario 'by data source' do
    acs  = create(:data_source, title: "ACS")
    dph  = create(:data_source, title: "DPH")
    map1 = create(:map, data_sources: [acs])
    map2 = create(:map, title: 'A diff map title', data_sources: [dph])

    visit static_maps_path
    filter_by :data_source, 'ACS'
    expect(page).to have_content(map1.title)
    expect(page).to_not have_content(map2.title)
  end

  pending 'by topic'

end
