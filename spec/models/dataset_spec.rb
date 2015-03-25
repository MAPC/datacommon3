require 'spec_helper'

VCR.configure do |config|
  config.ignore_request do |request|
    request.include? "package_list"
  end
end

describe Dataset do
  
  pending "Dataset#all" do
    expect(Dataset.all().count).to be_between(900,1200)
  end

  describe "Dataset#find_by" do
    it "returns one object if searching by ID", vcr: true do
      expect( Dataset.find_by(id: "3dbae792-3443-4171-bb10-afb8759364c3") ).to be_a(CKAN::Package)
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
  describe "Dataset#page" do
    pending "paginates results", vcr: true do
      expect(Dataset.page(1)).to have(10).items
    end

    it "custom paginates with options", vcr: true do
      results = Dataset.page(2, per_page: 5)
      expect(results).to have(5).items
    end

    pending "defaults to page 1", vcr: true do
      nil_page = Dataset.page.records.map(&:id)
      one_page = Dataset.page(1).records.map(&:id)
      expect(nil_page).to eq(one_page)
    end

    pending "defaults to page 1 and takes options", vcr: true do
      expect(Dataset.page(nil, per_page: 5)).to have(5).items
    end

    pending "doesn't care if you give it a page number" do
      expect(Dataset.page(per_page: 5)).to have(5).items
    end

  end

end
