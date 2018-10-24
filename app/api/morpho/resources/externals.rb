module Morpho
  module Resources
    class Externals < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
        Morpho::Helpers::JWTUtils,
        Morpho::Helpers::UserExternalLogin

      namespace :externals do
        desc 'Request user authentication from external provider' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::AuthenticationToken)
        end
        params do
          requires :data, type: Morpho::Entities::SignIn::External
        end
        post do
          login(params[:data])
        end
      end
    end
  end
end
