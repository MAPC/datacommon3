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

  it "ignores blank URLs" do
    profile.website_url = ""
    profile.save
    expect(profile.website_url).to be_empty
  end

  it "ignores nil URLs" do
    profile.website_url = nil
    profile.save
    expect(profile.website_url).to be_nil
  end

  it "conforms ignores conformed URLS" do
    profile.website_url = "https://github.com/beechnut"
    profile.save
    expect(profile.website_url).to eq("https://github.com/beechnut")
  end

  it "presents URLs nicely" do
    profile.website_url = "http://www.mapc.org/about-mapc/staff/"
    profile.save
    expect(profile.display_url).to eq("www.mapc.org/about-mapc/staff/")
  end

end
