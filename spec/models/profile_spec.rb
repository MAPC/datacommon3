require 'spec_helper'

describe Profile do
  subject(:profile) { build(:profile) }

  it "has a valid factory" do
    expect(profile).to be_valid
  end

  it "conforms URLs" do
    profile.website_url = "cloyd.io"
    profile.save
    expect(profile.website_url).to eq("http://cloyd.io")
  end

  it "conforms ignores conformed URLS" do
    profile.website_url = "https://github.com/beechnut"
    profile.save
    expect(profile.website_url).to eq("https://github.com/beechnut")
  end

end
