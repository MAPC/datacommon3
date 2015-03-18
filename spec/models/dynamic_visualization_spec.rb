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

  it 'requires a session state'
  it 'returns comma-separated years as a formatted string'

  describe 'preview' do

    # TODO: Pick up here
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

end


