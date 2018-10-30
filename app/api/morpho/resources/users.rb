module Morpho
  module Resources
    class Users < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :users do
        desc 'User registration' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::User)
          failure [
            [ 422, I18n.t('morpho.api.messages.unprocessable_entity'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::UserSignUp
        end
        post do
          result = Morpho::User::Operation::SignUp.call(params)

          if result.success?
            present result['model'], with: Morpho::Entities::User
          else
            case result['error']
            when :not_valid
              render_unprocessable_entity(result['contract'].errors)
            when :not_saved
              render_unprocessable_entity(result['model'].errors)
            else
              render_unprocessable_entity
            end
          end
        end
      end
    end
  end
end
