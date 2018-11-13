module Morpho
  module Resources
    class Users < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :users do
        desc 'User registration' do
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
          result = Morpho::User::Operation::SignUp.call(params)

          if result.success?
            present result['model'], with: Morpho::Entities::User
          end
        end
      end
    end
  end
end
