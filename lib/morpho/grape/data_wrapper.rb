module Morpho
  module Grape
    class DataWrapper
      attr_reader :model
      attr_reader :key
      attr_reader :is_array
      attr_reader :wrapper_name

      def initialize(model, wrapper_name: nil, key: :data, is_array: false)
        @model = model
        @wrapper_name = wrapper_name
        @key = key
        @is_array = is_array
      end

      def ancestors
        [DataWrapper]
      end

      def to_s
        wrapper_name ? wrapper_name : "data_wrapper_#{object_id}"
      end
    end
  end
end
