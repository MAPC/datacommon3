require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe SessionsHelper do
  
  subject(:user) { create(:user) }
  before { remember(user) }

  specify ".current_user returns right user when session is nil" do
    expect(current_user).to eq(user)
  end

  specify ".current_user returns nil user when remember digest is wrong" do
    user.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user).to be_nil
  end

end
