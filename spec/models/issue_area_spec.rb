require 'spec_helper'

describe IssueArea do
  subject(:topic) { build(:topic) }

  it "has a valid factory" do
    expect(topic).to be_valid
  end

  it "requires a title" do
    expect(build(:topic, title: '')).to_not be_valid
  end

  it "uses its given slug" do
    expect(create(:topic).slug).to eq('the-public-health')
  end

  it "generates a slug if given none" do
    expect(create(:topic, slug: nil).slug).to eq('public-health')
  end

  it "can be ordered"

end
