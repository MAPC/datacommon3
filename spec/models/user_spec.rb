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
    expect(user).to respond_to(:institution)
    expect(user).to respond_to(:institution_id)
  end

  it 'has helper methods' do
    # These should be values from the factory, not just another
    # method definition.
    expect(user.to_s).to eq(user.name)
    expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    expect(user.fname).to eq("#{user.first_name}")
    expect(user.activated?).to eq(user.activated_at.present?)
  end

  it 'treats edge case names with respect' do
    user = build(:user, first_name: "Edmund", last_name: "O'Reilly")
    expect(user.name).to eq("Edmund O'Reilly")
  end

  specify "#active? returns active state" do
    expect(user.active?).to eq(user.activated_at.present?)
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

    subject(:user) { build(:user, :inactive) }

    it 'requires a username' do
      expect(build(:user, username:  '')).to_not be_valid
      expect(build(:user, username: nil)).to_not be_valid
    end

    it 'requires a unique username, case-insensitive' do
      user1 = build(:user, :inactive, username: "the_user_name")
      user2 = user1.dup ; user2.username.upcase!
      expect(user1).to be_valid
      expect(user2).to be_valid
      user1.save!
      expect(user2).not_to be_valid
    end

    it 'rejects a username with special characters' do
      expect(user).to be_valid
      user.username = user.email
      expect(user).to_not be_valid
    end

    it 'requires an valid email address' do
      expect(build(:user, email:  '')).to_not be_valid
      expect(build(:user, email: nil)).to_not be_valid
      expect(build(:user, email: 'email-at.net')).to_not be_valid
    end

    it 'requires a unique email address' do
      user1 = build(:user, :inactive, email: "the.same@email.net")
      user2 = user1.dup
      expect(user1).to be_valid
      expect(user2).to be_valid
      user1.save!
      expect(user2).to_not be_valid
    end

    it 'requires a unique email address, case-insensitive' do
      user1 = build(:user, :inactive, email: "the.same@email.net")
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

    # TODO: Through the console, can't update without password.
    # May want to test for this later.

  end

  specify "#authenticated? returns false for a user with nil remember digest" do
    expect(user.authenticated?(:remember, '')).to be_false
    expect(user.authenticated?(:activation, '')).to be_false
  end

  it "knows its email host" do
    Rails.configuration.action_mailer.default_url_options[:host] = "datacommon.org"
    institution = create :institution
    user = build :user
    user.institution = institution
    expect(user.email_host).to eq('metroboston.datacommon.org')
  end

  it "knows its email host when institution changes" do
    Rails.configuration.action_mailer.default_url_options[:host] = "datacommon.org"
    other_institution = create :institution, :other
    user = build :user
    user.institution = other_institution
    expect(user.email_host).to eq('centralmass.datacommon.org')
  end

  it "resends activation emails" do
    user = create :user, :inactive
    expect {
      user.resend_activation_email
    }.to change{ ActionMailer::Base.deliveries.size }.by(1)
  end

  it "does not resend activation emails when already active" do
    user = create :user, :active
    expect(user.resend_activation_email).to be_false
  end

  it "displays the right name" do
    user = create :user, first_name: "na", last_name: "me"
    user.profile = nil
    expect(user.name).to eq("na me")
    user.create_profile
    expect(user.name).to eq("na me")
    user.profile.update_attribute :name, "Mert Clerd"
    expect(user.name).to eq("Mert Clerd")
  end


end
