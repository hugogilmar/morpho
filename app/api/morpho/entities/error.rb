# frozen_string_literal: true

module Morpho
  module Entities
    class Error < ::Grape::Entity
      expose :errors, safe: true, documentation: { type: 'array', desc: 'Error message details' }

      def errors
        messages = []

        keys = object.errors.keys

        keys.each do |key|
          messages << {
            field_name: key,
            messages: object.errors.messages[key]
          }
        end

        messages << {
          field_name: 'base',
          messages: [ object.message ]
        } if messages.empty?

        messages
      end
    end
  end
end
