module Morpho
  module Resources
    class Unlocks < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :unlocks do
        desc 'Request user unlock token' do
          detail ''
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::UserEmail)
          failure [
            [ 404, I18n.t('morpho.api.messages.general.404'), Morpho::Entities::Error ],
            [ 405, I18n.t('morpho.api.messages.general.405'), Morpho::Entities::Error ],
            [ 422, I18n.t('morpho.api.messages.general.422'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::UserEmail
        end
        post do
          result = Morpho::User::Operation::Unlock.call(params)

          if result.success?
            present result['model'], with: Morpho::Entities::User
          end
        end
      end
    end
  end
end
