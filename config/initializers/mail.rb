ActionMailer::Base.smtp_settings = {
  address:               "smtp.mandrillapp.com",
  port:                  25,  # ports 587 and 2525 are also supported with STARTTLS
  enable_starttls_auto:  true, # detects and uses STARTTLS
  user_name:             ENV.fetch('MANDRILL_USERNAME') { '' },
  password:              ENV.fetch('MANDRILL_API_KEY')  { '' },
  authentication:        'login', # Mandrill supports 'plain' or 'login'
  domain:                ENV.fetch('MANDRILL_DOMAIN') { 'datacommon.org' } # your domain to identify your server when connecting
}