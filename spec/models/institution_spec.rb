require 'spec_helper'

describe Institution do
  it "has a valid factory" do
    expect(build(:institution)).to be_valid
  end

  describe "validations" do

    it "requires a long name" do
      expect(build(:institution, long_name: '')).to_not be_valid
    end

    it "requires a short name" do
      expect(build(:institution, short_name: '')).to_not be_valid
    end

    it "requires a subdomain" do
      expect(build(:institution, subdomain: '')).to_not be_valid
    end

    it "requires an image logo" do
      expect(build(:institution, logo_file_name: '')).to_not be_valid
      expect(build(:institution, logo_content_type: 'application/octet')).to_not be_valid
    end

    specify "#camel_name removes the space(s) from the short name" do
      expect(build(:institution, short_name: "Metro Boston").camel_name).to eq("MetroBoston")
      expect(build(:institution, short_name: "L O L").camel_name).to eq("LOL")
    end

    specify "#to_s returns the camel name" do
      expect(build(:institution).to_s).to eq('MetroBoston')
    end
  end
end
