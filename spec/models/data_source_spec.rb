require 'spec_helper'

describe DataSource do
  
  subject(:source) { build(:data_source) }
  
  it "has a valid factory" do
    expect(source).to be_valid
  end

  it "requires a title" do
    expect(build(:source, title: '')).to_not be_valid
  end

  it "requires a description" do
    expect(build(:source, description: '')).to_not be_valid
  end

  it "uses its given slug" do
    expect(create(:source).slug).to eq('american-community-survey')
  end

  it "generates a slug if given none" do
    expect(create(:source, slug: nil).slug).to eq('acs')
  end

  it "requires a url" do
    expect(build(:source, url: '')).to_not be_valid
  end

  it "uses its given http:// url" do
    expect(create(:source, url: 'http://acs.org').url).to eq('http://acs.org')
  end

  it "gives the URL an http:// prefix if none given" do
    expect(create(:source, url: 'acs.org').url).to eq('http://acs.org')
  end
end
