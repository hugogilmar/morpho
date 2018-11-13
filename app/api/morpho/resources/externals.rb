module Morpho
  module Resources
    class Externals < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :externals do
        desc 'Request user authentication from external provider' do
          detail ''
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::AuthenticationToken)
          failure [
            [ 422, I18n.t('morpho.api.messages.general.422'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::External
        end
        post do
          result = Morpho::User::Operation::ExternalSignIn.call(params, ip: request.ip)

          if result.success?
            present result['token'], with: Morpho::Entities::AuthenticationToken
          end
        end
      end
    end
  end
end
