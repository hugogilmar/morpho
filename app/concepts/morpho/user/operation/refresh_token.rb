module Morpho
  class User::Operation::RefreshToken < Trailblazer::Operation
    step :validate
    fail :not_valid, fail_fast: true
    step :find
    fail :not_found, fail_fast: true
    step :generate_refresh_token
    pass :render

    def validate (options, **)
      options['contract'] = Morpho::User::Contract::RefreshToken.new(OpenStruct.new)
      options['contract'].validate(options['data'])
    end

    def find (options, **)
      options['model'] = Morpho::User.find_by(refresh_token: options['data']['refresh_token'])
    end

    def generate_refresh_token (options, **)
      options['model'].generate_refresh_token!
    end

    def not_valid (options, **)
      options['error'] = :not_valid
    end

    def not_found (options, **)
      options['error'] = :not_found
    end

    def render (options, **)
      options['token'] = Morpho::JWT::Payload.new(options['model'])
    end
  end
end
