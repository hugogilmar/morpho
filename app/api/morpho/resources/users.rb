module Morpho
  module Resources
    class Users < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
        Morpho::Helpers::UserRegistration

      namespace :users do
        desc 'User registration' do
          success Morpho::Entities::User
        end
        params do
          requires :data, type: Morpho::Entities::UserSignUp
        end
        post do
          register(params[:data])
        end
      end
    end
  end
end
