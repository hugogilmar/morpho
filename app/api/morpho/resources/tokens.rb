module Morpho
  module Resources
    class Tokens < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
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
      end
    end
  end
end
