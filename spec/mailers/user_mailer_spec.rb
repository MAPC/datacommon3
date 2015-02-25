require "spec_helper"

describe UserMailer do

  subject(:user) { create(:new_user, activation_token: User.new_token) }

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      mail.subject.should eq("Activate your account")
      mail.to.should eq([user.email])
      mail.from.should eq(["no-reply@datacommon.org"])
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
      mail.subject.should eq("Password reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["no-reply@datacommon.org"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
