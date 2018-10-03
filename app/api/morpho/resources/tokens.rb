module Morpho
  module Resources
    class Tokens < ::Grape::API
      helpers Morpho::Grape::HTTPResponses, Morpho::Grape::JWTAuthentication

      namespace :tokens do
        desc 'Request user authentication token' do
          success Morpho::Entities::AuthenticationToken
        end
        params do
          requires :user, type: Morpho::Entities::UserSignIn
        end
        post do
          login(params[:user])
        end
      end
    end
  end
end
