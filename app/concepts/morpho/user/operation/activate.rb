module Morpho
  class User::Operation::Activate < Trailblazer::Operation
    step :validate
    failure :not_valid, fail_fast: true
    step :find
    failure :not_found, fail_fast: true
    step :check
    failure :not_allowed, fail_fast: true
    step :activation_email
    failure :not_delivered
    success :render

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

    def not_valid (options, **)
      options['error'] = :not_valid
    end

    def not_found (options, **)
      options['error'] = :not_found
    end

    def not_allowed (options, **)
      options['error'] = :not_allowed
    end

    def not_delivered (options, **)
      options['error'] = :not_delivered
    end

    def render (options, **)
      options['model']
    end
  end
end
