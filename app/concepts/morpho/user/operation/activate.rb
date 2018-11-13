module Morpho
  class User::Operation::Activate < Trailblazer::Operation
    pass :validate!
    pass :find!
    pass :check!
    pass :activation_email!

    def validate!(options, **)
      options['contract'] = Morpho::User::Contract::Activate.new(OpenStruct.new)

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
      if options['model'].active?
        raise Morpho::Exceptions::StandardError.new(
          status: 405
        )
      end
    end

    def activation_email!(options, **)
      options['model'].resend_activation_needed_email!
    end
  end
end
