module Morpho
  module Resources
    class Tokens < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
        Morpho::Helpers::JWTUtils

      namespace :tokens do
        desc 'Request user authentication token' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::AuthenticationToken)
          failure [
            [ 401, I18n.t('morpho.api.messages.unauthorized'), Morpho::Entities::Error ],
            [ 403, I18n.t('morpho.api.messages.forbidden'), Morpho::Entities::Error ],
            [ 404, I18n.t('morpho.api.messages.not_found'), Morpho::Entities::Error ],
            [ 422, I18n.t('morpho.api.messages.unprocessable_entity'), Morpho::Entities::Error ],
            [ 423, I18n.t('morpho.api.messages.locked'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::Credentials
        end
        post do
          result = Morpho::User::Operation::SignIn.call(params, ip: request.ip)

          if result.success?
            present result['token'], with: Morpho::Entities::AuthenticationToken
          else
            case result['error']
            when :not_valid
              render_unprocessable_entity(result['contract'].errors)
            when :not_found
              render_not_found([I18n.t('morpho.api.messages.sign_in.unexistent')])
            when :not_active
              render_forbidden([I18n.t('morpho.api.messages.sign_in.unconfirmed')])
            when :locked
              render_locked([I18n.t('morpho.api.messages.sign_in.locked')])
            when :wrong_password
              render_unauthorized([I18n.t('morpho.api.messages.sign_in.bad_credentials')])
            else
              render_unprocessable_entity
            end
          end
        end

        desc 'Refresh user authentication token' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::AuthenticationToken)
          failure [
            [ 404, I18n.t('morpho.api.messages.not_found'), Morpho::Entities::Error ],
            [ 422, I18n.t('morpho.api.messages.unprocessable_entity'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::RefreshToken
        end
        post :refresh do
          result = Morpho::User::Operation::RefreshToken.call(params)

          if result.success?
            present result['token'], with: Morpho::Entities::AuthenticationToken
          else
            case result['error']
            when :not_valid
              render_unprocessable_entity(result['contract'].errors)
            when :not_found
              render_not_found([I18n.t('morpho.api.messages.refresh_token.invalid')])
            else
              render_unprocessable_entity
            end
          end
        end
      end
    end
  end
end
