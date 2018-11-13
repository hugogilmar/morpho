module Morpho
  module Formatters
    module StandardError
      class << self
        def call(message, backtrace, options, env, original_exception)
          if message.is_a?(String)
            result = {
              message: message,
              errors: [
                { field_name: 'base', messages: [ message ] }
              ]
            }
          elsif message.is_a?(Hash)
            result = message
          elsif message.is_a?(Object)
            return message.to_json if message.respond_to?(:to_json)

            result = message
          end

          ::Grape::Json.dump(result)
        end
      end
    end
  end
end
