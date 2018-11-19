# frozen_string_literal: true

Morpho.configure do |config|
  config.host = ENV.fetch('HOST', 'localhost:3000')
  config.protocol = ENV.fetch('PROTOCOL', 'http')
  config.mailer.from = ENV.fetch('MAILER_FROM', 'no-reply@example.com')
  config.mailer.address = ENV.fetch('MAILER_ADDRESS', 'smtp.mailtrap.io')
  config.mailer.user_name = ENV.fetch('MAILER_USER_NAME', '')
  config.mailer.password = ENV.fetch('MAILER_PASSWORD', '')
  config.mailer.port = ENV.fetch('MAILER_PORT', 2525)
  config.mailer.authentication = ENV.fetch('MAILER_AUTHENTICATION', 'login')
  config.mailer.enable_starttls_auto = ENV.fetch('MAILER_ENABLE_STARTTLS_AUTO', false)
  config.mailer.perform_deliveries = ENV.fetch('MAILER_PERFORM_DELIVERIES', false)
  config.mailer.delivery_method = ENV.fetch('MAILER_DELIVER_METHOD', 'smtp')
  config.jwt.secret = ''
  config.jwt.algorithm = 'HS256'
  config.jwt.header = 'Authorization'
  config.jwt.expiration_time = 1.hour
  config.api.title = ''
  config.api.description = ''
  config.auth.failed_login_attempts_limit = 5
end
