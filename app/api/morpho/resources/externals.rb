module Morpho
  module Resources
    class Externals < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :externals do
        desc 'Request user authentication from external provider' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::AuthenticationToken)
        end
        params do
          requires :data, type: Morpho::Entities::External
        end
        post do
          result = Morpho::User::Operation::ExternalSignIn.call(params, ip: request.ip)

          if result.success?
            present result['token'], with: Morpho::Entities::AuthenticationToken
          else
            case result['error']
            when :not_valid
              render_unprocessable_entity(result['contract'].errors)
            else
              render_unprocessable_entity
            end
          end
        end
      end
    end
  end
end
