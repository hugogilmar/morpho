Morpho.configure do |config|
  config.host = 'localhost:3000'
  config.mailer.from = ''
  config.mailer.address = 'smtp.mailtrap.io'
  config.mailer.user_name = ''
  config.mailer.password = ''
  config.mailer.port = 2525
  config.mailer.authentication = 'login'
  config.mailer.enable_starttls_auto = false
  config.jwt.secret = ''
  config.jwt.algorithm = 'HS256'
  config.jwt.header = 'Authorization'
  config.api.title = ''
  config.api.description = ''
end
