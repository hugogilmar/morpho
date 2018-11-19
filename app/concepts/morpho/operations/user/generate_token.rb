# frozen_string_literal: true

module Morpho
  module Operations
    module User
      class GenerateToken < Morpho::Operations::Base::Find
        pass :data!, after: :params!
        pass :validate!, before: :build_model!
        pass :check!, before: :present!

        def data!(options, params:, **)
          options['data'] = params['data'].is_a?(Hash) ? params.fetch('data') : {}
        end

        def validate!(options, data:, **)
          options['contract'] = options['contract.class'].new(OpenStruct.new)

          unless options['contract'].validate(data)
            raise Morpho::Exceptions::StandardError.new(
              errors: options['contract'].errors
            )
          end
        end

        def build_model!(_options, **)
          raise NotImplementedError
        end

        def check!(_options, **)
          raise NotImplementedError
        end
      end
    end
  end
end
