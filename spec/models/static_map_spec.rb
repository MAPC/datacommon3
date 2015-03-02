require 'spec_helper'

describe StaticMap do

  subject(:map) { build(:map) }
  
  it "has a valid factory" do
    expect(map).to be_valid
  end

  it "requires a title" do
    expect(build(:map, title: nil)).to_not be_valid
  end

  it "requires a month and year" do
    expect(build(:map, month: nil)).to_not be_valid
    expect(build(:map, year:  nil)).to_not be_valid
  end

  it "requires an abstract" do
    expect(build(:map, abstract: '')).to_not be_valid
  end

  it "requires an attachment" do
    expect(build(:map_without_attachment)).to_not be_valid
  end

  it "requires a PDF attachment" do
    expect(build(:map, map_content_type: 'application/xml')).to_not be_valid
  end

  it "does not require an institution" do
    expect(build(:map, institution_id: nil)).to be_valid
  end

  it "does not require legacy fields" do
    expect(build(:map, pdf_page:  nil)).to be_valid
    expect(build(:map, thumbnail: nil)).to be_valid
  end

end
