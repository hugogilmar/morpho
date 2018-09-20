module Morpho
  class Engine < ::Rails::Engine
    isolate_namespace Morpho
    engine_name 'morpho'

    initializer 'morpho.migrations', before: :load_config_initializers do |app|
      config.paths['db/migrate'].expanded.each do |expanded_path|
        app.config.paths['db/migrate'] << expanded_path
      end
    end

    initializer 'morpho.configurations', before: :load_config_initializers do |app|
      app.config.action_mailer.delivery_method = :smtp
      app.config.action_mailer.smtp_settings = {
        address: Morpho.config.mailer_address,
        port: Morpho.config.mailer_address,
        user_name: Morpho.config.mailer_user_name,
        password: Morpho.config.mailer_password,
        authentication: Morpho.config.mailer_authentication,
        enable_starttls_auto: Morpho.config.mailer_enable_starttls_auto
      }
    end
  end
end
