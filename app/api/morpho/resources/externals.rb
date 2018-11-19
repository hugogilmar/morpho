# frozen_string_literal: true

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
          result = Morpho::Operations::User::ExternalSignIn.call(
            'params' => params,
            'model.class' => Morpho::User,
            'contract.class' => Morpho::Contracts::User::ExternalSignIn,
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
