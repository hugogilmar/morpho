module Morpho
  module Operations
    module User
      class ResendActivationEmail < Morpho::Operations::User::DeliverEmail
        def build_model!(options, data:, **)
          options['model'] = options['model.class'].find_by(email: data.fetch('email'))

          if options['model'].nil?
            raise Morpho::Exceptions::StandardError.new(
              message: I18n.t('morpho.api.messages.activate.email_not_exists'),
              status: 404
            )
          end
        end

        def check!(options, model:, **)
          if model.active?
            raise Morpho::Exceptions::StandardError.new(
              message: I18n.t('morpho.api.messages.activate.account_already_confirmed'),
              status: 405
            )
          end
        end

        def deliver!(options, model:, **)
          model.resend_activation_needed_email!
        end
      end
    end
  end
end
