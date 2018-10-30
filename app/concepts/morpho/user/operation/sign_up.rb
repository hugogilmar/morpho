module Morpho
  class User::Operation::SignUp < Trailblazer::Operation
    step :validate
    fail :not_valid, fail_fast: true
    step :sync
    fail :not_synced, fail_fast: true
    step :save
    fail :not_saved, fail_fast: true
    pass :render

    def validate(options, **)
      options['contract'] = Morpho::User::Contract::SignUp.new(Morpho::User.new)
      options['contract'].validate(options['data'])
    end

    def sync(options, **)
      options['contract'].sync
    end

    def save (options, **)
      options['model'] = options['contract'].model
      options['model'].save
    end

    def not_valid(options, **)
      options['error'] = :not_valid
    end

    def not_synced(options, **)
      options['error'] = :not_synced
    end

    def not_saved(options, **)
      options['error'] = :not_saved
    end

    def render(options, **)
      options['model']
    end
  end
end
