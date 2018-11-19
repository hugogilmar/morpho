# frozen_string_literal: true

module Morpho
  module Operations
    module Base
      # Base fetch operation
      class Fetch < Trailblazer::Operation
        pass :init!
        pass :params!
        pass :meta!
        pass :model_class!
        pass :build_build_models!
        pass :filter!
        pass :page!
        pass :paginate!
        pass :search!
        pass :update_meta!
        pass :present!

        def init!(options, **)
          options['default.page.size'] ||= 25
        end

        def params!(options, **)
          options['params'] ||= {}
        end

        def meta!(options, params:, **)
          options['meta'] = params.fetch('meta', {})
        end

        def update_meta!(options, **)
          if options['models'].try(:current_page)
            options['meta'].merge!(
              'current_page' => options['models'].current_page,
              'from' => options['models'].prev_page,
              'last_page' => options['models'].total_pages,
              'per_page' => options['models'].limit_value,
              'to' => options['models'].next_page,
              'total' => options['models'].total_count
            )
          end
          options
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

        def build_models!(options, **)
          options['models'] = options['model.class'].all
        end

        def filter!(options, params:, **)
          options['filter'] = params.fetch('filter', {})
        end

        def page!(options, params:, **)
          options['page'] = params.fetch(
            'page',
            'number' => 1,
            'size' => options['default.page.size']
          )
        end

        def paginate!(options, page:, **)
          page_size = page.fetch('size', 25)
          page_number = page.fetch('number', 1)
          if  page &&
              page_size.to_i.positive?
            options['models'] = options['models']
                                .page(page_number)
                                .per(page_size)
          end
          options
        end

        def search!(options, **)
          options['models'] = options['models']
                              .ransack(options['filter'])
                              .result(distinct: options['ransack.distinct'])
        end

        def present!(options, meta:, models:, **)
          data =
            if options['presenter.class']
              options['presenter.class'].represent(models)['data']
            else
              models
            end
          options['response'] = {
            data: data,
            meta: meta
          }
        end
      end
    end
  end
end
