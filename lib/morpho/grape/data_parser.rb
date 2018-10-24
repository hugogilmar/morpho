module Morpho
  module Grape
    class DataParser
      attr_reader :wrapper
      attr_reader :endpoint

      def initialize(wrapper, endpoint)
        @wrapper = wrapper
        @endpoint = endpoint
      end

      def call
        memo = {}

        name = endpoint.send(:expose_params_from_model, wrapper.model)

        memo[wrapper.key] = if wrapper.is_array
          {
            type: :array,
            items: {
              '$ref' => "#/definitions/#{name}"
            }
          }
        else
          {
            type: :object,
            '$ref' => "#/definitions/#{name}"
          }
        end

        memo
      end
    end
  end
end
