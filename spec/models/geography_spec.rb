require 'spec_helper'

describe Geography do
  subject(:geo) { build(:geography) }

  it 'has a valid factory' do
    expect(geo).to be_valid
  end

  pending "institution scope" do
    let(:geo_1) { create(:geography, institution_id: 1, type: :subregion) }
    let(:geo_2) { create(:geography, institution_id: 2, type: :municipality) }
    let(:inst)  { build_stubbed(Institution, id: 1) }

    context "only" do
      it "returns snapshots from given institution" do
        expect(Geography.institution(inst, only: true)).to eq([geo_1])
      end

      it "returns snapshots from given institution" do
        expect(Geography.institution(inst, only: false, default: false)).to eq([geo_1, geo_2])
      end
    end
  end

end