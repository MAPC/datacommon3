require 'spec_helper'

describe DynamicVisualization do

  subject(:visual) { build(:dynamic_visual) }
  
  it 'has a valid factory' do
    expect(visual).to be_valid
  end

  it 'requires a title' do
    expect(build(:dynamic_visual, title: '')).to_not be_valid
  end

  it 'requires a session_state_file_name' do
    expect(build(:dynamic_visual, session_state_file_name: '')).to_not be_valid
  end

  it 'generates a sessionstate' do
    expect(visual.sessionstate).to match(visual.session_state_file_name)
  end

  it 'requires an overviewmap' do
    expect(build(:dynamic_visual, overviewmap: '')).to_not be_valid
  end

  it 'requires at least a 4-digit year' do
    expect(build(:dynamic_visual, year: '')).to_not be_valid
    expect(build(:dynamic_visual, year: '09')).to_not be_valid
    expect(build(:dynamic_visual, year: '009')).to_not be_valid
  end

  it 'returns comma-separated years as an enumerable' do
    expect(build(:dynamic_visual, year: "2000,2012").years).to eq(["2000", "2012"])
    expect(build(:dynamic_visual, year: "2000").years).to eq(["2000"])
    expect(build(:dynamic_visual, year: "5 yr average").years).to eq(["5 yr average"])
  end

  describe 'preview' do

    let(:geo) { build_stubbed(Geography) }

    before do
      geo.stub(:slug) { 'north-winchendon' }
      geo.stub(:id)    { 351 }
      visual.stub(:id) { 99 }
      Rails.configuration.stub(:paperclip_defaults) {
        {:storage => :filesystem,
         :url     => "/system/:class/:attachment/:style/:filename",
         :path    => "/Users/mapcuser/Projects/datacommon/public/system/:class/:attachment/:style/:filename"}
      }
    end

    it 'responds to Paperclip-like methods' do
      expect(visual).to respond_to(:preview)
      expect(visual.preview(geo)).to respond_to(:path)
      expect(visual.preview(geo)).to respond_to(:url)
    end

    specify '#path returns a modified version of Paperclip path' do
      expect(visual.preview(geo).path).to eq(
        "/Users/mapcuser/Projects/datacommon/public/system/dynamic_visualizations/images/north-winchendon/99.png"
      )
    end

    specify '#url returns a modified version of Paperclip url' do
      expect(visual.preview(geo).url).to eq(
        "/system/dynamic_visualizations/images/north-winchendon/99.png"
      )
    end
  end

  describe '#state' do
    # In order to render a session state, we need the visualization
    # and its collaborator, the geography object.
    # We'll stub the geography object like in the last example.

    let(:geo) { build_stubbed(Geography) }

    before do
      geo.stub(:id)          {  12   }
      geo.stub(:unitid)      { "351" }
      geo.stub(:unit_id)     { "351" }
      geo.stub(:subunit_ids) { "25,252,121" }
      # Stub the session state.
      file = <<-ERB
        <tag>MUNI_ID,<%= object.unitid %></tag>
        <tag>MUNI_ID,<%= object.unit_id %>,<%= object.subunit_ids %>,352</tag>
      ERB
      allow(File).to receive(:read).and_return(file)
    end

    it 'returns a rendered state' do
      rendered = <<-ERB
        <tag>MUNI_ID,351</tag>
        <tag>MUNI_ID,351,25,252,121,352</tag>
      ERB
      expect(visual.state(geo)).to eq(rendered)
    end
  end

  
  describe "associations" do
    it "has them" do
      [:data_sources, :topics].each do |assoc|
        expect(visual).to respond_to(assoc)
        expect(visual.send(assoc)).to respond_to(:each)    
      end
    end
  end

  pending "data source and topic filters"

end


