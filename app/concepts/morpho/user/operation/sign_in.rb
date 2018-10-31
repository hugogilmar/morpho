module Morpho
  class User::Operation::SignIn < Trailblazer::Operation
    step :validate
    fail :unprocessable_entity, fail_fast: true
    step :find
    fail :not_found, fail_fast: true
    step :check_active
    fail :forbidden, fail_fast: true
    step :check_unlocked
    fail :locked, fail_fast: true
    step :check_password
    fail :unauthorized, fail_fast: true
    step :generate_refresh_token
    step :register_last_login_activity
    step :authentication_token

    def validate (options, **)
      options['contract'] = Morpho::User::Contract::SignIn.new(OpenStruct.new)
      options['contract'].validate(options['data'])
    end

    def find (options, **)
      options['model'] = Morpho::User.find_by(email: options['data']['email'])
    end

    def check_active (options, **)
      options['model'].active?
    end

    def check_unlocked (options, **)
      options['model'].unlocked?
    end

    def check_password (options, **)
      options['model'].valid_password?(options['data']['password'])
    end

    def generate_refresh_token (options, **)
      options['model'].generate_refresh_token!
    end

    def register_last_login_activity (options, **)
      options['model'].register_last_login_activity!(options['ip'])
    end

    def unprocessable_entity (options, **)
      options['error'] = :unprocessable_entity
    end

    def not_found (options, **)
      options['error'] = :not_found
    end

    def forbidden (options, **)
      options['error'] = :forbidden
    end

    def locked (options, **)
      options['error'] = :locked
    end

    def unauthorized (options, **)
      options['model'].register_failed_login!
      options['error'] = :unauthorized
    end

    def authentication_token (options, **)
      options['token'] = Morpho::JWT::Payload.new(options['model'])
    end
  end
end
