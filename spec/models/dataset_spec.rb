require 'spec_helper'

describe Dataset do
  
  pending "Dataset#all" do
    expect(Dataset.all().count).to be_between(900,1200)
  end

  describe "Dataset#find_by", vcr: true do
    it "returns one object if searching by ID" do
      expect(
        Dataset.find_by(id: "3dbae792-3443-4171-bb10-afb8759364c3")
      ).to have(1).item
    end

    it "returns multiple when searching by tags" do
      expect(Dataset.find_by(tags: "government")).to have_at_least(3).items
    end
  end

  describe "Dataset#page", vcr: true do
    it "paginates results" do
      expect(Dataset.page(1)).to have(10).items
    end

    it "custom paginates with options" do
      results = Dataset.page(2, paginates_per: 5)
      expect(results).to have(5).items
    end

    it "defaults to page 1" do
      nil_page = Dataset.page.map(&:id)
      one_page = Dataset.page(1).map(&:id)
      
      expect(nil_page).to eq(one_page)
      expect(Dataset.page(nil, paginates_per: 5)).to have(5).items
    end

    pending "doesn't care if you give it a page number" do
      expect(Dataset.page(paginates_per: 5)).to have(5).items
    end

  end

end
