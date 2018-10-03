module Morpho
  module Grape
    module HTTPResponses
      extend ActiveSupport::Concern

      protected

      def render_bad_request
        error!({ message: I18n.t('morpho.api.messages.bad_request') }, 400)
      end

      def render_unauthorized
        error!({ message: I18n.t('morpho.api.messages.unauthorized') }, 401)
      end

      def render_payment_required
        error!({ message: I18n.t('morpho.api.messages.payment_required') }, 402)
      end

      def render_forbidden
        error!({ message: I18n.t('morpho.api.messages.forbidden') }, 403)
      end

      def render_not_found
        error!({ message: I18n.t('morpho.api.messages.not_found') }, 404)
      end

      def render_method_not_allowed
        error!({ message: I18n.t('morpho.api.messages.method_not_allowed') }, 405)
      end

      def render_unprocessable_entity(errors)
        error!({ message: I18n.t('morpho.api.messages.unprocessable_entity'), errors: errors }, 422)
      end

      def render_no_content
        body false
      end
    end
  end
end
