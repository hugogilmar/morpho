module Morpho
  module Helpers
    module HTTPResponses
      protected

      def render_bad_request
        raise Morpho::Exceptions::StandardError.new(
          status: 400
        )
      end

      def render_unauthorized
        raise Morpho::Exceptions::StandardError.new(
          status: 401
        )
      end

      def render_payment_required
        raise Morpho::Exceptions::StandardError.new(
          status: 402
        )
      end

      def render_forbidden
        raise Morpho::Exceptions::StandardError.new(
          status: 403
        )
      end

      def render_not_found
        raise Morpho::Exceptions::StandardError.new(
          status: 404
        )
      end

      def render_method_not_allowed
        raise Morpho::Exceptions::StandardError.new(
          status: 405
        )
      end

      def render_unprocessable_entity
        raise Morpho::Exceptions::StandardError.new(
          status: 422
        )
      end

      def render_locked
        raise Morpho::Exceptions::StandardError.new(
          status: 423
        )
      end

      def render_no_content
        body false
      end
    end
  end
end
