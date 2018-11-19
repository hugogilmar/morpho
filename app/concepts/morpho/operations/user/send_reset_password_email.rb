# frozen_string_literal: true

module Morpho
  module Operations
    module User
      class SendResetPasswordEmail < Morpho::Operations::User::DeliverEmail
        def build_model!(options, data:, **)
          options['model'] = options['model.class'].find_by(email: data.fetch('email'))

          if options['model'].nil?
            raise Morpho::Exceptions::StandardError.new(
              message: I18n.t('morpho.api.messages.unlock.email_not_exists'),
              status: 404
            )
          end
        end

        def check!(options, model:, **)
          if options['model'].external?
            raise Morpho::Exceptions::StandardError.new(
              status: 405
            )
          end
        end

        def deliver!(options, model:, **)
          model.deliver_reset_password_instructions!
        end
      end
    end
  end
end
