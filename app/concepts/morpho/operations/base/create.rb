# frozen_string_literal: true

module Morpho
  module Operations
    module Base
      # Base create operation
      class Create < Morpho::Operations::Base::Form
        def build_model!(options, **)
          options['model'] = options['model.class'].new
        end
      end
    end
  end
end
