module Morpho
  class User::Operation::ResetPassword < Trailblazer::Operation
    pass :validate!
    pass :find!
    pass :check!
    pass :reset_password_email!

    def validate!(options, **)
      options['contract'] = Morpho::User::Contract::ResetPassword.new(OpenStruct.new)

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
          status: 404
        )
      end
    end

    def check!(options, **)
      if options['model'].external?
        raise Morpho::Exceptions::StandardError.new(
          status: 405
        )
      end
    end

    def reset_password_email!(options, **)
      options['model'].deliver_reset_password_instructions!
    end
  end
end
