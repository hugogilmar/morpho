module Morpho
  class User::Operation::SignUp < Trailblazer::Operation
    pass :validate!
    pass :sync!
    pass :save!

    def validate!(options, **)
      options['contract'] = Morpho::User::Contract::SignUp.new(Morpho::User.new)

      unless options['contract'].validate(options['data'])
        raise Morpho::Exceptions::StandardError.new(
          errors: options['contract'].errors
        )
      end
    end

    def sync!(options, **)
      options['contract'].sync
    end

    def save!(options, **)
      options['model'] = options['contract'].model
      options['model'].save

      unless options['model'].persisted?
        raise Morpho::Exceptions::StandardError.new(
          errors: options['model'].errors
        )
      end
    end
  end
end
