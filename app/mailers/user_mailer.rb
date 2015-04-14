class UserMailer < ActionMailer::Base
  # include Resque::Mailer
  default from: "no-reply@datacommon.org"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user_id)
    @user = User.find_by(id: user_id)

    mail to: @user.email, subject: "Activate your account"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user_id)
    @user = User.find_by(id: user_id)

    mail to: @user.email, subject: "Reset your password"
  end
end
