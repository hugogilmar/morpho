module Morpho
  module Helpers
    module HTTPResponses
      protected

      def render_bad_request
        error!({ message: I18n.t('morpho.api.messages.bad_request'), with: Morpho::Entities::Error }, 400)
      end

      def render_unauthorized
        error!({ message: I18n.t('morpho.api.messages.unauthorized'), with: Morpho::Entities::Error }, 401)
      end

      def render_unauthorized_detailed(errors)
        error!({ message: I18n.t('morpho.api.messages.unauthorized'), errors: errors, with: Morpho::Entities::Error }, 401)
      end

      def render_payment_required
        error!({ message: I18n.t('morpho.api.messages.payment_required'), with: Morpho::Entities::Error }, 402)
      end

      def render_forbidden
        error!({ message: I18n.t('morpho.api.messages.forbidden'), with: Morpho::Entities::Error }, 403)
      end

      def render_not_found
        error!({ message: I18n.t('morpho.api.messages.not_found'), with: Morpho::Entities::Error }, 404)
      end

      def render_method_not_allowed
        error!({ message: I18n.t('morpho.api.messages.method_not_allowed'), with: Morpho::Entities::Error }, 405)
      end

      def render_unprocessable_entity
        error!({ message: I18n.t('morpho.api.messages.unprocessable_entity'), with: Morpho::Entities::Error }, 422)
      end

      def render_unprocessable_entity_detailed(errors)
        error!({ message: I18n.t('morpho.api.messages.unprocessable_entity'), errors: errors, with: Morpho::Entities::Error }, 422)
      end

      def render_no_content
        body false
      end
    end
  end
end
