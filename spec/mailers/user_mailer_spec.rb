require "spec_helper"

describe UserMailer do

  describe "account_activation" do
    subject(:user) { create(:user, :inactive, activation_token: User.new_token) }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Activate your account")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@datacommon.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Activate")
      expect(mail.body.encoded).to match(user.activation_token)
      expect(mail.body.encoded).to match(CGI::escape(user.email))
    end
  end

  describe "password_reset" do
    subject(:user) { create(:user, reset_token: User.new_token) }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Reset your password")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@datacommon.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("To reset your password")
      expect(mail.body.encoded).to match(user.reset_token)
      expect(mail.body.encoded).to match(CGI::escape(user.email))
    end
  end

end
