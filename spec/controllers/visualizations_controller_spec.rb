require 'spec_helper'

describe VisualizationsController do

  describe 'GET index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET show' do
    before { @visual = create :visual }
    it 'responds successfully' do
      get :show, { id: @visual.id }
      expect(response).to be_success
    end
  end

end