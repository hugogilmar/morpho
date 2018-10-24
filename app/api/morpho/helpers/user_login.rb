module Morpho
  module Helpers
    module UserLogin
      protected

      def logged_in?
        !!current_user
      end

      def require_login
        render_unauthorized unless logged_in?
      end

      def login(user_params)
        user = Morpho::User.find_by(email: user_params[:email])

        if user
          if user.active?
            if !user.login_locked?
              if user.valid_password?(user_params[:password])
                render_authentication_token(user)
              else
                user.register_failed_login!
                render_unauthorized_detailed([I18n.t('morpho.api.messages.unauthorized_detailed.bad_credentials')])
              end
            else
              render_unauthorized_detailed([I18n.t('morpho.api.messages.unauthorized_detailed.locked')])
            end
          else
            render_unauthorized_detailed([I18n.t('morpho.api.messages.unauthorized_detailed.unconfirmed')])
          end
        else
          render_unauthorized_detailed([I18n.t('morpho.api.messages.unauthorized_detailed.unexistent')])
        end
      end

      def render_authentication_token(user)
        user.register_last_login_activity!(request.ip)
        user.generate_refresh_token!
        token = user_payload(user)

        present token, with: Morpho::Entities::SignIn::AuthenticationToken
      end
    end
  end
end
