# frozen_string_literal: true

module Morpho
  module Operations
    module Base
      # Base update operation
      class Update < Morpho::Operations::Base::Form
        def build_model!(options, params:, **)
          options['model'] = options['model.class'].find_by(uuid: params['uuid'])

          if options['model']
             .nil?
            raise Morpho::Exceptions::StandardError.new(status: 404)
          end
        end
      end
    end
  end
end
