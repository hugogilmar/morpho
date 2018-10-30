module Morpho
  module Helpers
    module HTTPResponses
      protected

      def render_bad_request(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.bad_request'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 400)
      end

      def render_unauthorized(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.unauthorized'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 401)
      end

      def render_unauthorized_detailed(errors = [])
        render_unauthorized(errors)
      end

      def render_payment_required(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.payment_required'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 402)
      end

      def render_forbidden(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.forbidden'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 403)
      end

      def render_not_found(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.not_found'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 404)
      end

      def render_method_not_allowed(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.method_not_allowed'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 405)
      end

      def render_unprocessable_entity(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.unprocessable_entity'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 422)
      end

      def render_locked(errors = [])
        error!({
          message: I18n.t('morpho.api.messages.locked'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 423)
      end

      def render_unprocessable_entity_detailed(errors = [])
        render_unprocessable_entity(errors)
      end

      def render_no_content
        body false
      end
    end
  end
end
