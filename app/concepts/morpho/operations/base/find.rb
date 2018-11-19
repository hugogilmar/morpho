# frozen_string_literal: true

module Morpho
  module Operations
    module Base
      # Base find operation
      class Find < Trailblazer::Operation
        pass :params!
        pass :model_class!
        pass :presenter_class!
        pass :build_model!
        pass :present!

        def params!(options, **)
          options['params'] ||= {}
        end

        def model_class!(options, **)
          model_class = options['model.class']
          unless model_class.is_a?(Class) && model_class.ancestors
                                                        .include?(
                                                          ::ActiveRecord::Base
                                                        )
            raise ArgumentError,
                  'Supply a valid model.class option'
          end
        end

        def presenter_class!(options, **)
          presenter_class = options['presenter.class']
          unless presenter_class.is_a?(Class) && presenter_class.ancestors
                                                                .include?(
                                                                  ::Grape::Entity
                                                                )
            raise ArgumentError,
                  'Supply a valid presenter.class option'
          end
        end

        def build_model!(options, params:, **)
          options['model'] = options['model.class'].find_by(uuid: params['uuid'])

          if options['model']
             .nil?
            raise Morpho::Exceptions::StandardError.new(status: 404)
          end
        end

        def present!(options, model:, **)
          options['response'] = options['presenter.class'].represent(model)
        end
      end
    end
  end
end
