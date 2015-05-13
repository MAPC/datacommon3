require 'spec_helper'

describe SnapshotsController do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    context "GET show: legacy paths" do
      it "catches 'cities-and-towns' and 'subregions'" do
        ['cities-and-towns', 'subregions'].each do |param|
          get :show, { id: param }
          expect(response.status.to_s).to match(/30[1-2]/) # Moved Permanently or Found
        end
      end
    end

    context "GET detail: legacy paths" do
      it "catches 'cities-and-towns' and 'subregions'" do
        ['cities-and-towns', 'subregions'].each do |param|
          get :detail, { id: 'boston', snapshot_id: param }
          expect(response.status.to_s).to match(/30[1-2]/) # Moved Permanently or Found
        end
      end
    end

  end
end