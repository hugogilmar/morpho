module Morpho
  class User::Operation::ExternalSignIn < Trailblazer::Operation
    pass :validate!
    pass :find_authentication!
    pass :find_user!
    pass :sign_in!
    pass :register!
    pass :sign_up!
    pass :generate_refresh_token!
    pass :register_last_login_activity!
    pass :authentication_token!

    def validate!(options, **)
      options['contract'] = Morpho::User::Contract::ExternalSignIn.new(OpenStruct.new)

      unless options['contract'].validate(options['data'])
        raise Morpho::Exceptions::StandardError.new(
          errors: options['contract'].errors
        )
      end
    end

    def find_authentication!(options, **)
      options['authentication.model'] = Morpho::Authentication.find_by(
        uid: options['data']['uid'],
        provider: options['data']['provider']
      )
    end

    def find_user!(options, **)
      options['user.model'] = Morpho::User.find_by(email: options['data']['email'])
    end

    def sign_in!(options, **)
      if options['authentication.model']
        options['user.model'] = options['authentication.model'].user
      end
    end

    def register!(options, **)
      if options['user.model'] && options['authentication.model'].nil?
        provider = options['data']['provider'].downcase

        options['user.model'].add_provider_to_user(provider, options['data']['uid'])
      end
    end

    def sign_up!(options, **)
      if options['user.model'].nil? && options['authentication.model'].nil?
        provider = options['data']['provider'].downcase

        options['user.model'] = Morpho::User.create_from_provider(provider, options['data']['uid'], {
          email: options['data']['email']
        })
      end
    end

    def generate_refresh_token!(options, **)
      options['user.model'].generate_refresh_token!
    end

    def register_last_login_activity!(options, **)
      options['user.model'].register_last_login_activity!(options['ip'])
    end

    def authentication_token!(options, **)
      options['token'] = ::Morpho::JWT::Payload.new(options['user.model'])
    end
  end
end
