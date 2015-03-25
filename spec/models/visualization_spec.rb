require 'spec_helper'

describe Visualization do
  subject(:visual) { build(:visualization) }
  before { 
    Institution.stub(:pluck) { [1,2] }
  }

  it "has a valid factory" do
    expect(visual).to be_valid
  end

  it "requires a title" do
    expect(build(:visual, title: nil)).to_not be_valid
    expect(build(:visual, title: "hi")).to_not be_valid
  end

  it "requires year to be a certain length" do
    expect(build(:visual, year: nil)).to be_valid
    expect(build(:visual, year: "02")).to_not be_valid
  end

  it "requires a verbose abstract" do
    expect(build(:visual, abstract: nil)).to_not be_valid
    expect(build(:visual, abstract: "z"*69)).to_not be_valid
  end

  it "requires an permission" do
    [nil, :foo].each { |perm|
      expect(build(:visual, permission: perm)).to_not be_valid
    }
    [:public, :private].each { |perm|
      expect(build(:visual, permission: perm)).to be_valid
    }
  end

  it "requires an institution" do
    expect(build(:visual, institution_id: nil)).to be_valid
    expect(build(:visual, institution_id: 3)).to_not be_valid
  end

  it "requires a reasonable sessionstate" do
    expect(build(:visual, sessionstate: nil)).to_not be_valid
    expect(build(:visual, sessionstate: "xml"*33)).to_not be_valid
  end

  specify "#to_s returns the title" do
    expect(visual.to_s).to eq(visual.title)
  end

  describe "associations" do
    it "has them" do
      [:data_sources, :topics].each do |assoc|
        expect(visual).to respond_to(assoc)
        expect(visual.send(assoc)).to respond_to(:each)    
      end
      expect(visual).to respond_to(:institution)
    end
  end
end

