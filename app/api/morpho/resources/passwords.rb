module Morpho
  module Resources
    class Passwords < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :passwords do
        desc 'Request user reset password token' do
          detail ''
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::User)
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
          result = Morpho::User::Operation::ResetPassword.call(params)

          if result.success?
            present result['model'], with: Morpho::Entities::User
          end
        end
      end
    end
  end
end
