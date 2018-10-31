module Morpho
  class User::Operation::Activate < Trailblazer::Operation
    step :validate
    fail :unprocessable_entity, fail_fast: true
    step :find
    fail :not_found, fail_fast: true
    step :check
    fail :method_not_allowed, fail_fast: true
    pass :activation_email

    def validate (options, **)
      options['contract'] = Morpho::User::Contract::Activate.new(OpenStruct.new)
      options['contract'].validate(options['data'])
    end

    def find (options, **)
      options['model'] = Morpho::User.find_by(email: options['data']['email'])
    end

    def check (options, **)
      !options['model'].active?
    end

    def activation_email (options, **)
      options['model'].resend_activation_needed_email!
    end

    def unprocessable_entity (options, **)
      options['error'] = :unprocessable_entity
    end

    def not_found (options, **)
      options['error'] = :not_found
    end

    def method_not_allowed (options, **)
      options['error'] = :method_not_allowed
    end
  end
end
