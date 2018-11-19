# frozen_string_literal: true

module Morpho
  module Operations
    module Base
      # Base form operation
      class Form < Trailblazer::Operation
        pass :params!
        pass :data!
        pass :model_class!
        pass :presenter_class!
        pass :contract_class!
        pass :build_model!
        pass :validate!
        pass :persist!
        pass :present!

        def params!(options, **)
          options['params'] ||= {}
        end

        def data!(options, params:, **)
          options['data'] = params['data'].is_a?(Hash) ? params.fetch('data') : {}
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

        def contract_class!(options, **)
          contract_class = options['contract.class']
          unless contract_class.is_a?(Class) && contract_class.ancestors
                                                              .include?(
                                                                ::Reform::Form
                                                              )
            raise ArgumentError,
                  'Supply a valid contract.class option'
          end
        end

        def build_model!(_options, **)
          raise NotImplementedError
        end

        def validate!(options, model:, data:, **)
          options['contract'] = options['contract.class'].new(model)

          valid = options['contract'].validate(data)

          raise Morpho::Exceptions::StandardError.new(errors: options['contract'].errors) unless valid
        end

        def persist!(options, contract:, **)
          contract.sync
          saved = contract.model.save

          raise Morpho::Exceptions::StandardError.new(errors: contract.errors) unless saved
        end

        def present!(options, model:, **)
          options['response'] = options['presenter.class'].represent(model)
        end
      end
    end
  end
end
