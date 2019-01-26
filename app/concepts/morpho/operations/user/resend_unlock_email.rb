module Morpho
  module Operations
    module User
      class ResendUnlockEmail < Morpho::Operations::User::DeliverEmail
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
          unless options['model'].login_locked?
            raise Morpho::Exceptions::StandardError.new(
              message: I18n.t('morpho.api.messages.unlock.account_not_locked'),
              status: 405
            )
          end
        end

        def deliver!(options, model:, **)
          model.resend_unlock_token_email!
        end
      end
    end
  end
end
