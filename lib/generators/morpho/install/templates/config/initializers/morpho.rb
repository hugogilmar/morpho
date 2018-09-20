Morpho.configure do |config|
  config.mailer_from = ''
  config.mailer_address = 'smtp.mailtrap.io'
  config.mailer_user_name = ''
  config.mailer_password = ''
  config.mailer_port = 2525
  config.mailer_authentication = 'login'
  config.mailer_enable_starttls_auto = false
end
