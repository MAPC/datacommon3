require 'spec_helper'

feature 'Visitor filters static maps' do

  pending 'by data source' do
    visit static_maps_path
    filter_by :data_source, map.data_sources.first.title
    expect(page).to have_content(map.title)
    expect(page).to_not have_content(map2.title)
  end


  pending 'by topic' do
    visit static_maps_path
    filter_by :topic, map.issue_areas.first.title
  end

end
