module Morpho
  module Resources
    class Users < Grape::API
      helpers Morpho::JWTGrape

      namespace :users do
        desc 'User registration' do
          success Morpho::Entities::User
        end
        params do
          requires :user, type: Morpho::Entities::UserSignUp
        end
        post do
          register(params[:user])
        end
      end
    end
  end
end
