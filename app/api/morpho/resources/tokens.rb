module Morpho
  module Resources
    class Tokens < Grape::API
      helpers Morpho::JWTGrape

      namespace :tokens do
        desc 'User login' do
          success Morpho::Entities::AuthenticationToken
        end
        params do
          requires :user, type: Morpho::Entities::UserSignIn
        end
        post do
          login(params[:user][:email], params[:user][:password])
        end
      end
    end
  end
end
