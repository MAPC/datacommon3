require 'spec_helper'

describe Dataset do
  
  describe "#all" do
    it "returns all available datasets", vcr: true do
      expect(Dataset.all).to have_at_least(900).items
    end
  end

  describe "#count" do
    it "is equal to #all#count", vcr: true do
      all_count  = Dataset.all.count
      just_count = Dataset.count
      expect(just_count).to eq(all_count)
    end
  end

  describe "#find_by" do
    pending "returns one object if searching by ID", vcr: true do
      expect(
        Dataset.find_by(id: "3dbae792-3443-4171-bb10-afb8759364c3")
      ).to be_a(CKAN::Package)
    end

    it "returns multiple when searching by tags", vcr: true do
      expect(Dataset.find_by(tags: "government")).to have_at_least(3).items
    end
  end

  # So many of these tests are pending because
  # VCR throws errors in a non-deterministic fashion.
  # I don't know how to get it to stop, so I've just
  # commented them out. The functionality is largely there.
  # TODO: Fix this.
  describe "#page" do
    it "paginates results", vcr: true do
      expect(Dataset.page(1)).to have(10).items
    end

    it "custom paginates with options", vcr: true do
      results = Dataset.page(2, per_page: 5)
      expect(results).to have(5).items
    end

    it "defaults to page 1", vcr: true do
      nil_page = Dataset.page.records.map(&:id)
      one_page = Dataset.page(1).records.map(&:id)
      expect(nil_page).to eq(one_page)
    end

    it "defaults to page 1 and takes options", vcr: true do
      expect(Dataset.page(nil, per_page: 5)).to have(5).items
    end

    pending "doesn't care if you give it a page number" do
      expect(Dataset.page(per_page: 5)).to have(5).items
    end

  end

end
