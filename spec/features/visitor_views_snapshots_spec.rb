require 'spec_helper'

feature 'Visitor views snapshots' do
  
  let!(:city)   { create(:municipality) }
  let!(:region) { create(:subregion) }
  let!(:topic)  { create(:topic) }

  let!(:city_visual)   { create(:dynamic_visual, title: 'Muni visual',   issue_area_ids: [topic.id], type: city.type) }
  let!(:region_visual) { create(:dynamic_visual, title: 'Region visual', issue_area_ids: [topic.id], type: region.type) }
  
  before do
    # Prevent GeoJSON lookup
    Geography.any_instance.stub(:to_geojson) { '-' }
    DynamicVisualization.any_instance.stub(:preview) { 
      OpenStruct.new(path: '', url: '')
    }
  end

  # Failing now that we're limiting it to just that institution
  # should probably mock an institution and assign geography to it.
  pending 'see index page with list' do
    visit snapshots_path
    [city, region].each { |place| expect(page).to have_content(place.name) }
  end

  scenario 'views each page' do
    [city, region].each do |place|
      visit snapshot_path(place)
      expect( all ".visual.preview.#{place.type}" ).to_not be_empty
      expect(page).to have_content( place.name  )
      expect(page).to have_content( topic.title )
    end
  end

  scenario 'municipal and topic-specific snapshots' do
    [snapshot_path(city),
    snapshot_topic_path(city, topic)].each do |path|
      visit path
      expect(page).to have_content(city_visual.title)
      expect(page).to_not have_content(region_visual.title)
    end
  end

  scenario 'subregional and topic-specific snapshots' do
    [snapshot_path(region),
    snapshot_topic_path(region, topic)].each do |path|
      visit path
      expect(page).to have_content(region_visual.title)
      expect(page).to_not have_content(city_visual.title)
    end
  end

end