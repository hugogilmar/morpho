module Morpho
  module Resources
    class Tokens < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
        Morpho::Helpers::JWTUtils,
        Morpho::Helpers::UserLogin,
        Morpho::Helpers::UserRefreshAuthenticationToken

      namespace :tokens do
        desc 'Request user authentication token' do
          success Morpho::Entities::SignIn::Success
          failure [
            [ 401, I18n.t('morpho.api.messages.unauthorized'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::SignIn::Credentials
        end
        post do
          login(params[:data])
        end

        desc 'Refresh user authentication token' do
          success Morpho::Entities::SignIn::Success
          failure [
            [ 422, I18n.t('morpho.api.messages.unprocessable_entity'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::SignIn::RefreshToken
        end
        post :refresh do
          refresh_token(params[:data])
        end
      end
    end
  end
end
