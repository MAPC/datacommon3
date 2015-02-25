class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@datacommon.org"
  layout 'mailer'
end