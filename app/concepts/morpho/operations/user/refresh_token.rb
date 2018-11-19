# frozen_string_literal: true

module Morpho
  module Operations
    module User
      class RefreshToken < Morpho::Operations::User::GenerateToken
        def build_model!(options, data:, **)
          options['model'] = options['model.class'].find_by(refresh_token: data.fetch('refresh_token'))

          if options['model'].nil?
            raise Morpho::Exceptions::StandardError.new(
              message: I18n.t('morpho.api.messages.refresh_token.invalid'),
              status: 404
            )
          end
        end

        def check!(options, model:, data:, **)
          unless model.active?
            raise Morpho::Exceptions::StandardError.new(
              message: I18n.t('morpho.api.messages.refresh_token.account_not_confirmed'),
              status: 403
            )
          end

          unless model.unlocked?
            raise Morpho::Exceptions::StandardError.new(
              message: I18n.t('morpho.api.messages.refresh_token.account_locked'),
              status: 423
            )
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
