module Morpho
  class User::Operation::Unlock < Trailblazer::Operation
    pass :validate!
    pass :find!
    pass :check!
    pass :unlock_token_email!

    def validate!(options, **)
      options['contract'] = Morpho::User::Contract::Unlock.new(OpenStruct.new)

      unless options['contract'].validate(options['data'])
        raise Morpho::Exceptions::StandardError.new(
          errors: options['contract'].errors
        )
      end
    end

    def find!(options, **)
      options['model'] = Morpho::User.find_by(email: options['data']['email'])

      if options['model'].nil?
        raise Morpho::Exceptions::StandardError.new(
          message: I18n.t('morpho.api.messages.unlock.email_not_exists'),
          status: 404
        )
      end
    end

    def check!(options, **)
      unless options['model'].login_locked?
        raise Morpho::Exceptions::StandardError.new(
          message: I18n.t('morpho.api.messages.unlock.account_not_locked'),
          status: 405
        )
      end
    end

    def unlock_token_email!(options, **)
      options['model'].resend_unlock_token_email!
    end
  end
end
