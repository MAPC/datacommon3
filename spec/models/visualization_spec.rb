require 'spec_helper'

describe Visualization do
  subject(:visual) { build(:visualization) }

  before do
    Institution.stub(:pluck) { [1,2] }
  end

  it "has a valid factory" do
    expect(visual).to be_valid
  end

  it "requires a title" do
    expect(build(:visual, title: nil)).to_not be_valid
    expect(build(:visual, title: "hi")).to_not be_valid
  end

  it "requires year to be a certain length" do
    expect(build(:visual, year:  nil)).to be_valid
    expect(build(:visual, year:  "02")).to_not be_valid
  end

  it "requires an institution" do
    expect(build(:visual, institution_id: nil)).to be_valid
    # expect(build(:visual, institution_id: 3)).to_not be_valid
  end

  it "requires a reasonable sessionstate" do
    expect(build(:visual, sessionstate: nil)).to_not be_valid
    expect(build(:visual, sessionstate: "xml"*33)).to_not be_valid
  end

end


#   specify "#date returns a stamped date" do
#     expect(map.date).to eq("January 2015")
#   end

#   specify "#to_s returns the title" do
#     expect(map.to_s).to eq(map.title)
#   end

#   it "orders itself by ID" do
#     map1 = create(:visual)
#     map2 = create(:visual)
#     expect(StaticMap.all).to eq([map2, map1])
#   end

#   describe "institution scope" do
#     let(:visual_1) { create(:visual, institution_id: 2) }
#     let(:visual_2) { create(:visual, institution_id: 1) }
#     let(:inst)  { create(:institution, id: 1) }

#     context "without institutions" do
#       it "returns all maps in order of creation" do
#         expect(StaticMap.institution(nil, default: false)).to eq([map_1, map_2])
#       end
#     end

#     context "with institutions" do
#       it "returns all maps sorted to = institution#id" do
#         results = StaticMap.institution(inst)
#         expect(results).to eq([map_2, map_1])
#       end

#       it "returns all maps sorted to = institution_id" do
#         results = StaticMap.institution(inst.id)
#         expect(results).to eq([map_2, map_1])
#       end
#     end
#   end

#   describe "associations" do
#     it "has them" do
#       [:data_sources, :topics].each do |assoc|
#         expect(map).to respond_to(assoc)
#         expect(map.send(assoc)).to respond_to(:each)    
#       end
#     end
#   end

# end