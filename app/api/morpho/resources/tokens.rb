# frozen_string_literal: true

module Morpho
  module Resources
    class Tokens < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :tokens do
        desc 'Request user authentication token' do
          detail ''
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::AuthenticationToken)
          failure [
            [ 401, I18n.t('morpho.api.messages.general.401'), Morpho::Entities::Error ],
            [ 403, I18n.t('morpho.api.messages.general.403'), Morpho::Entities::Error ],
            [ 404, I18n.t('morpho.api.messages.general.404'), Morpho::Entities::Error ],
            [ 422, I18n.t('morpho.api.messages.general.422'), Morpho::Entities::Error ],
            [ 423, I18n.t('morpho.api.messages.general.423'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::Credentials
        end
        post do
          result = Morpho::Operations::User::SignIn.call(
            'params' => params,
            'model.class' => Morpho::User,
            'contract.class' => Morpho::Contracts::User::SignIn,
            'presenter.class' => Morpho::Entities::AuthenticationToken,
            'ip_address' => request.ip
          )

          if result.success?
            present result['response']
          end
        end

        desc 'Refresh user authentication token' do
          detail ''
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::AuthenticationToken)
          failure [
            [ 403, I18n.t('morpho.api.messages.general.403'), Morpho::Entities::Error ],
            [ 404, I18n.t('morpho.api.messages.general.404'), Morpho::Entities::Error ],
            [ 422, I18n.t('morpho.api.messages.general.422'), Morpho::Entities::Error ],
            [ 423, I18n.t('morpho.api.messages.general.423'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::RefreshToken
        end
        post :refresh do
          result = Morpho::Operations::User::RefreshToken.call(
            'params' => params,
            'model.class' => Morpho::User,
            'contract.class' => Morpho::Contracts::User::RefreshToken,
            'presenter.class' => Morpho::Entities::AuthenticationToken,
            'ip_address' => request.ip
          )

          if result.success?
            present result['response']
          end
        end
      end
    end
  end
end
