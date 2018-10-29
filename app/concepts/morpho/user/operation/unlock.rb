module Morpho
  class User::Operation::Unlock < Trailblazer::Operation
    step :validate
    failure :not_valid, fail_fast: true
    step :find
    failure :not_found, fail_fast: true
    step :check
    failure :not_allowed, fail_fast: true
    step :unlock_token_email
    failure :not_delivered
    success :render

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
