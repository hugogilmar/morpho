module Morpho
  class User::Operation::Unlock < Trailblazer::Operation
    step :validate
    fail :unprocessable_entity, fail_fast: true
    step :find
    fail :not_found, fail_fast: true
    step :check
    fail :method_not_allowed, fail_fast: true
    pass :unlock_token_email

    def validate (options, **)
      options['contract'] = Morpho::User::Contract::Unlock.new(OpenStruct.new)
      options['contract'].validate(options['data'])
    end

    def find (options, **)
      options['model'] = Morpho::User.find_by(email: options['data']['email'])
    end

    def check (options, **)
      options['model'].login_locked?
    end

    def unlock_token_email (options, **)
      options['model'].resend_unlock_token_email!
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
