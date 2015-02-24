require 'spec_helper'

describe User do

  subject(:user) { create(:user) }
  
  it "has a valid factory" do
    expect(user).to be_valid
  end

  it 'responds to the right methods' do
    expect(user).to respond_to(:name)
    expect(user).to respond_to(:fname)
    expect(user).to respond_to(:avatar_url)
    expect(user).to respond_to(:profile)
    expect(user).to respond_to(:visualizations)
  end

  it 'has helper methods' do
    expect(user.to_s).to eq(user.name)
    expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    expect(user.fname).to eq("#{user.first_name}")
  end

  it 'generates a Gravatar URL with default 75px' do
    gravatar_id = Digest::MD5.hexdigest(user.email)  
    expect(user.avatar_url).to eq("http://gravatar.com/avatar/#{gravatar_id}.png?s=75")
  end

  it 'generates a Gravatar URL with a given size' do
    gravatar_id = Digest::MD5.hexdigest(user.email)  
    expect(user.avatar_url(100)).to eq("http://gravatar.com/avatar/#{gravatar_id}.png?s=100")
  end

  describe 'validations' do
    
    subject(:user) { build(:new_user) }

    it 'requires a username' do
      expect(build(:user, username:  '')).to_not be_valid
      expect(build(:user, username: nil)).to_not be_valid
    end

    it 'requires an valid email address' do
      expect(build(:user, email:  '')).to_not be_valid
      expect(build(:user, email: nil)).to_not be_valid
      expect(build(:user, email: 'email-at.net')).to_not be_valid
    end

    it 'requires a unique email address' do
      user1 = create(:new_user, email: "the.same@email.net")
      user2 = build(:new_user,  email: "the.same@email.net")
      expect(user2).not_to be_valid
    end
  end

  # Mock profiles?

end
