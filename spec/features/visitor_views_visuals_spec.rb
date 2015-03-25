require 'spec_helper'
 
describe 'Visitor views visuals', :vcr do
  
  before do
    visit visualizations_path
  end
   
  it 'displays all visualizations' do
    visuals = all '#visuals .visual'
    visuals.should_not be_empty
    visuals.each do |visual|
      visual.find('a')[:href].should match(/visualizations/)
    end
  end
end 