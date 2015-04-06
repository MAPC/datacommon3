require 'spec_helper'
 
describe 'Visitor views visuals', :vcr do
  
  before do
    15.times { create(:visualization) }
    visit visualizations_path
  end

  let(:visuals)    { all '#visuals .visual' }
  let(:pagination) { all '.pagination'      }
   
  it 'displays all visualizations, paginated' do
    expect(visuals).to_not be_empty
    expect(pagination).to_not be_empty
    visuals.each do |visual|
      expect( 
        visual.first('a')[:href]
      ).to match(/visualizations\/\d+/)
    end

  end
end


feature 'Visitor views single visualization' do
  before do
    @visual = create(:visualization)
    visit visualization_path(@visual)
  end

  scenario 'shows visualizationd details' do
    %w( title abstract owner ).each do |method|
      expect(page).to have_content( @visual.send(method) )
    end
  end

end