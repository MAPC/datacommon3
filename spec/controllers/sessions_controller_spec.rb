require 'spec_helper'

describe SessionsController do

  describe "POST create" do
    let(:user) { build_stubbed(User) }

    before do
      User.stub(:find_by) { user }
      user.stub(:authenticate) { true }
      user.stub(:update_attribute) { true }
    end

    it "sets a remember cookie" do
      post :create, session: {
        username: user.username,
        password: user.password,
        remember_me: 1
      }
      expect(cookies["remember_token"]).to_not be_nil
    end

    it "does not set a remember cookie" do
      post :create, session: {
        username: user.username,
        password: user.password,
        remember_me: 0
      }
      expect(cookies["remember_token"]).to be_nil
    end

    it "renders the user's profile" do
      post :create, session: {
        username: user.username,
        password: user.password,
        remember_me: 1
      }
      expect(response.status).to eq(302)
      # expect(response).to render_template("users/show")
    end

  end
end