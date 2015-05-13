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
  end

  describe "GET show" do
    it "responds successfully" do
      get :show, { id: 'boston' }
      expect(response).to be_success
    end
  end

  describe "GET detail" do
    it "responds successfully" do
      topic = create :topic
      geo   = create :geo

      get :detail, { id: topic.slug, snapshot_id: geo.slug }
      expect(response).to be_success
    end
  end

  context "legacy" do

    describe "GET show" do
      it "catches 'cities-and-towns' and 'subregions'" do
        ['cities-and-towns', 'subregions'].each do |param|
          get :show, { id: param }
          expect(response.status.to_s).to match(/30[1-2]/) # Moved Permanently or Found
        end
      end
    end

    describe "GET detail" do
      it "catches 'cities-and-towns' and 'subregions'" do
        ['cities-and-towns', 'subregions'].each do |param|
          get :detail, { id: 'boston', snapshot_id: param }
          expect(response.status.to_s).to match(/30[1-2]/) # Moved Permanently or Found
        end
      end
    end

  end

end