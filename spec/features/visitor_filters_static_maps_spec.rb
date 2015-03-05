require 'spec_helper'


feature 'Visitor filters static maps' do

  scenario 'by data source' do
    acs  = create(:source,         title: 'ACS')
    dph  = create(:another_source, title: 'DPH')
    map  = create(:map, data_sources: [acs])
    map2 = create(:map, title: 'The other map', data_sources: [dph])
    visit static_maps_path(data_source: acs.id)
    expect(page).to have_content map.title
    expect(page).not_to have_content map2.title
  end

  scenario 'by topic' do
    topic = create(:topic)
    visit static_maps_path
    expect(page).to have_content topic.title
  end

end
