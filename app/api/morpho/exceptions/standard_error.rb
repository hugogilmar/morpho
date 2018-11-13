module Morpho
  module Exceptions
    class StandardError < ::StandardError
      attr_reader :status_code

      def initialize(*args)
        options = args.extract_options!

        @status_code = options[:status_code] || 422
        @message = options[:message] || I18n.t("morpho.api.messages.general.#{@status_code}")
        @errors = options[:errors] || {}

        super(@message)
      end

      def present
        messages = []

        if @errors.respond_to?(:messages)
          @errors.messages.keys.each do |key|
            messages << {
              field_name: key,
              messages: @errors.messages.fetch(key, [])
            }
          end
        else
          messages << { field_name: :base, messages: [ @message ] }
        end

        messages
      end
    end
  end
end
