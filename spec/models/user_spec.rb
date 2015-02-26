require 'spec_helper'

describe User do

  subject(:user) { build(:user) }
  
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
    expect(user.activated?).to eq(user.is_active)
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

    it 'requires a unique username, case-insensitive' do
      user1 = build(:new_user,  username: "the_user_name")
      user2 = user1.dup ; user2.username.upcase!
      expect(user1).to be_valid
      expect(user2).to be_valid
      user1.save!
      expect(user2).not_to be_valid
    end

    it 'requires an valid email address' do
      expect(build(:user, email:  '')).to_not be_valid
      expect(build(:user, email: nil)).to_not be_valid
      expect(build(:user, email: 'email-at.net')).to_not be_valid
    end

    it 'requires a unique email address' do
      user1 = build(:new_user, email: "the.same@email.net")
      user2 = user1.dup
      expect(user1).to be_valid
      expect(user2).to be_valid
      user1.save!
      expect(user2).to_not be_valid
    end

    it 'requires a unique email address, case-insensitive' do
      user1 = build(:new_user, email: "the.same@email.net")
      user2 = user1.dup ; user2.email.upcase!
      expect(user1).to be_valid
      expect(user2).to be_valid
      user1.save!
      expect(user2).to_not be_valid
    end

    it 'requires a first and last name' do
      expect(build(:user, first_name: '')).to_not be_valid
      expect(build(:user, last_name:  '')).to_not be_valid
    end

    it 'requires a first and last name no more than 30 characters' do
      expect(build(:user, first_name: 'f'*31 )).to_not be_valid
      expect(build(:user, last_name:  'l'*31 )).to_not be_valid
    end

    it 'requires a confirmed password between 5 and 128 characters' do
      expect(build(:user, password: '')).to_not be_valid
      expect(build(:user, password: '1234')).to_not be_valid
      expect(build(:user, password: 'p'*129 )).to_not be_valid
      expect(build(:user, password: nil)).to_not be_valid
      expect(build(:user, password_confirmation: '')).to_not be_valid
    end
  end

  specify "#authenticated? returns false for a user with nil remember digest" do
    expect(user.authenticated?(:remember, '')).to be_false
    expect(user.authenticated?(:activation, '')).to be_false
  end

  # Mock profiles?

end
