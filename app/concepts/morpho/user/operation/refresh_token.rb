module Morpho
  class User::Operation::RefreshToken < Trailblazer::Operation
    pass :validate!
    pass :find!
    pass :generate_refresh_token!
    pass :authentication_token!

    def validate!(options, **)
      options['contract'] = Morpho::User::Contract::RefreshToken.new(OpenStruct.new)

      unless options['contract'].validate(options['data'])
        raise Morpho::Exceptions::StandardError.new(
          errors: options['contract'].errors
        )
      end
    end

    def find!(options, **)
      options['model'] = Morpho::User.find_by(refresh_token: options['data']['refresh_token'])

      if options['model'].nil?
        raise Morpho::Exceptions::StandardError.new(
          status_code: 404
        )
      end
    end

    def generate_refresh_token!(options, **)
      options['model'].generate_refresh_token!
    end

    def authentication_token!(options, **)
      options['token'] = ::Morpho::JWT::Payload.new(options['model'])
    end
  end
end
