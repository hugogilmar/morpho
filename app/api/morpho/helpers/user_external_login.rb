module Morpho
  module Helpers
    module UserExternalLogin
      protected

      def login(user_params)
        provider = user_params[:provider].downcase

        if Morpho::Authentication.exists?(provider: provider, uid: user_params[:uid])
          authentication = Morpho::Authentication.find_by(provider: provider, uid: user_params[:uid])

          user = authentication.user

          user.activate! unless user.active?
          user.register_last_login_activity!(request.ip)
          user.generate_refresh_token!
          token = user_payload(user)

          present token, with: Morpho::Entities::SignIn::AuthenticationToken
        elsif Morpho::User.exists?(email: user_params[:email])
          user = Morpho::User.find_by(email: user_params[:email])

          if user.add_provider_to_user(provider, user_params[:uid])
            user.activate! unless user.active?
            user.register_last_login_activity!(request.ip)
            user.generate_refresh_token!
            token = user_payload(user)

            present token, with: Morpho::Entities::SignIn::AuthenticationToken
          else
            render_unprocessable_entity_detailed([I18n.t('morpho.api.messages.provider.unregistered')])
          end
        else
          user = Morpho::User.create_from_provider(provider, user_params[:uid], {
            email: user_params[:email],
            name: user_params[:name]
          })

          if user.persisted?
            user.activate!
            user.register_last_login_activity!(request.ip)
            user.generate_refresh_token!
            token = user_payload(user)

            present token, with: Morpho::Entities::SignIn::AuthenticationToken
          else
            render_unprocessable_entity_detailed([I18n.t('morpho.api.messages.provider.unregistered')])
          end
        end
      end
    end
  end
end
