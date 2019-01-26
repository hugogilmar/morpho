module Morpho
  module Resources
    class Activations < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :activations do
        desc 'Resend activation instructions email' do
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
        post :resend_activation_email do
          result = Morpho::Operations::User::ResendActivationEmail.call(
            'params' => params,
            'model.class' => Morpho::User,
            'contract.class' => Morpho::Contracts::User::ResendActivationEmail,
            'presenter.class' => Morpho::Entities::User
          )

          if result.success?
            present result['response']
          end
        end
      end
    end
  end
end
