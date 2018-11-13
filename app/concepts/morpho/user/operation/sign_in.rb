module Morpho
  class User::Operation::SignIn < Trailblazer::Operation
    pass :validate!
    pass :find!
    pass :check_active!
    pass :check_unlocked!
    pass :check_password!
    pass :generate_refresh_token!
    pass :register_last_login_activity!
    pass :authentication_token!

    def validate!(options, **)
      options['contract'] = Morpho::User::Contract::SignIn.new(OpenStruct.new)

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
          message: I18n.t('morpho.api.messages.sign_in.email_not_exists'),
          status: 404
        )
      end
    end

    def check_active!(options, **)
      unless options['model'].active?
        raise Morpho::Exceptions::StandardError.new(
          message: I18n.t('morpho.api.messages.sign_in.account_not_confirmed'),
          status: 403
        )
      end
    end

    def check_unlocked!(options, **)
      unless options['model'].unlocked?
        raise Morpho::Exceptions::StandardError.new(
          message: I18n.t('morpho.api.messages.sign_in.account_locked'),
          status: 423
        )
      end
    end

    def check_password!(options, **)
      unless options['model'].valid_password?(options['data']['password'])
        options['model'].register_failed_login!
        raise Morpho::Exceptions::StandardError.new(
          message: I18n.t('morpho.api.messages.sign_in.bad_credentials'),
          status: 401
        )
      end
    end

    def generate_refresh_token!(options, **)
      options['model'].generate_refresh_token!
    end

    def register_last_login_activity!(options, **)
      options['model'].register_last_login_activity!(options['ip'])
    end

    def authentication_token!(options, **)
      options['token'] = ::Morpho::JWT::Payload.new(options['model'])
    end
  end
end
