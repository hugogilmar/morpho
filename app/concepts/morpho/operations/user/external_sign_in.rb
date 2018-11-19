# frozen_string_literal: true

module Morpho
  module Operations
    module User
      class ExternalSignIn < Morpho::Operations::User::GenerateToken
        step nil, delete: :check!, id: ''

        def build_model!(options, data:, **)
          provider = data.fetch('provider').downcase

          options['model'] = Morpho::User.load_from_provider(
            provider, data.fetch('uid')
          )

          if options['model'].nil?
            options['model'] = Morpho::User.find_by(email: data.fetch('email'))

            unless options['model'].nil?
              options['model'].add_provider_to_user(provider, data.fetch('uid'))
            end
          end

          if options['model'].nil?
            options['model'] = Morpho::User.create_from_provider(provider, data.fetch('uid'), {
              email: data.fetch('email')
            })
          end
        end

        def present!(options, model:, **)
          model.generate_refresh_token!
          model.register_last_login_activity!(options['ip_address'])
          token = Morpho::JWT::Payload.new(model)
          options['response'] = options['presenter.class'].represent(token)
        end
      end
    end
  end
end
