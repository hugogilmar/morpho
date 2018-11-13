module Morpho
  module Helpers
    module HTTPResponses
      protected

      def render_bad_request(errors = {})
        error!({
          message: I18n.t('morpho.api.messages.general.400'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 400)
      end

      def render_unauthorized(errors = {})
        raise Morpho::Exceptions::StandardError.new(
          I18n.t('morpho.api.messages.general.401'),
          status_code: 401
        )
        # error!({
        #   message: I18n.t('morpho.api.messages.general.401'),
        #   errors: errors,
        #   with: Morpho::Entities::Error
        # }, 401)
      end

      def render_unauthorized_detailed(errors = {})
        render_unauthorized(errors)
      end

      def render_payment_required(errors = {})
        error!({
          message: I18n.t('morpho.api.messages.general.402'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 402)
      end

      def render_forbidden(errors = {})
        error!({
          message: I18n.t('morpho.api.messages.general.403'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 403)
      end

      def render_not_found(errors = {})
        error!({
          message: I18n.t('morpho.api.messages.general.404'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 404)
      end

      def render_method_not_allowed(errors = {})
        error!({
          message: I18n.t('morpho.api.messages.general.405'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 405)
      end

      def render_unprocessable_entity(errors = {})
        error!({
          message: I18n.t('morpho.api.messages.general.422'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 422)
      end

      def render_locked(errors = {})
        error!({
          message: I18n.t('morpho.api.messages.general.423'),
          errors: errors,
          with: Morpho::Entities::Error
        }, 423)
      end

      def render_unprocessable_entity_detailed(errors = {})
        render_unprocessable_entity(errors)
      end

      def render_no_content
        body false
      end
    end
  end
end
