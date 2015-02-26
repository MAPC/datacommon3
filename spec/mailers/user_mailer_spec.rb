require "spec_helper"

describe UserMailer do

  subject(:user) { create(:new_user, activation_token: User.new_token) }

  describe "account_activation" do
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

  pending "password_reset" do
    let(:mail) { UserMailer.password_reset }

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@datacommon.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
