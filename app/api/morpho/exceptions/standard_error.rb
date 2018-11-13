module Morpho
  module Exceptions
    class StandardError < ::StandardError
      attr_reader :status
      attr_reader :message
      attr_reader :errors

      def initialize(*args)
        options = args.extract_options!

        @status = options[:status] || 422
        @message = options[:message] || I18n.t("morpho.api.messages.general.#{@status}")
        @errors = options[:errors] || {}

        super(@message)
      end
    end
  end
end
