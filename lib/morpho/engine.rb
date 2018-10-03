module Morpho
  class Engine < ::Rails::Engine
    isolate_namespace Morpho
    engine_name 'morpho'

    initializer 'morpho.paths', before: :set_autoload_paths do |app|
      config.autoload_paths << File.expand_path('app/api', __dir__)
    end

    initializer 'morpho.migrations', before: :load_config_initializers do |app|
      config.paths['db/migrate'].expanded.each do |expanded_path|
        app.config.paths['db/migrate'] << expanded_path
      end
    end

    initializer 'morpho.configurations', after: :load_config_initializers do |app|
      ActionMailer::Base.delivery_method = :smtp
      ActionMailer::Base.perform_deliveries = true

      ActionMailer::Base.default_options = {
        from: Morpho.config.mailer.from
      }

      ActionMailer::Base.default_url_options = {
        host: Morpho.config.host
      }

      ActionMailer::Base.smtp_settings = {
        address: Morpho.config.mailer.address,
        port: Morpho.config.mailer.port,
        user_name: Morpho.config.mailer.user_name,
        password: Morpho.config.mailer.password,
        authentication: Morpho.config.mailer.authentication,
        enable_starttls_auto: Morpho.config.mailer.enable_starttls_auto
      }
    end
  end
end
