module Morpho
  module Helpers
    module UserRefreshAuthenticationToken
      protected

      def valid_refresh_token?(refresh_token_params)
        Morpho::User.exists?(refresh_token: refresh_token_params[:refresh_token])
      end

      def refresh_token(refresh_token_params)
        if self.valid_refresh_token?(refresh_token_params)
          user = Morpho::User.find_by(refresh_token: refresh_token_params[:refresh_token])

          user.generate_refresh_token!
          token = user_payload(user)

          present token, with: Morpho::Entities::SignIn::AuthenticationToken
        else
          render_unprocessable_entity_detailed([I18n.t('morpho.api.messages.refresh_token.invalid')])
        end
      end
    end
  end
end
