# frozen_string_literal: true

module Morpho
  module Resources
    class Users < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :users do
        desc 'User sign up' do
          detail ''
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::User)
          failure [
            [ 422, I18n.t('morpho.api.messages.general.422'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::UserSignUp
        end
        post do
          result = Morpho::Operations::User::SignUp.call(
            'params' => params,
            'model.class' => Morpho::User,
            'contract.class' => Morpho::Contracts::User::SignUp,
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
