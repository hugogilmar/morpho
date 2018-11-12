module Morpho
  module Resources
    class Tokens < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses

      namespace :tokens do
        desc 'Request user authentication token' do
          detail ''
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
            when :unprocessable_entity
              render_unprocessable_entity(result['contract'].errors)
            when :not_found
              render_not_found({ base: I18n.t('morpho.api.messages.sign_in.not_found') })
            when :forbidden
              render_forbidden({ base: I18n.t('morpho.api.messages.sign_in.forbidden') })
            when :locked
              render_locked({ base: I18n.t('morpho.api.messages.sign_in.locked') })
            when :unauthorized
              render_unauthorized({ base: I18n.t('morpho.api.messages.sign_in.unauthorized') })
            else
              render_unprocessable_entity
            end
          end
        end

        desc 'Refresh user authentication token' do
          detail ''
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
            when :unprocessable_entity
              render_unprocessable_entity(result['contract'].errors)
            when :not_found
              render_not_found({ base: I18n.t('morpho.api.messages.refresh_token.not_found') })
            else
              render_unprocessable_entity
            end
          end
        end
      end
    end
  end
end
