module Morpho
  module Resources
    class Unlocks < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
        Morpho::Helpers::UserUnlock

      namespace :unlocks do
        desc 'Request user unlock token' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::UserEmail)
          failure [
            [ 404, I18n.t('morpho.api.messages.not_found'), Morpho::Entities::Error ],
            [ 405, I18n.t('morpho.api.messages.method_not_allowed'), Morpho::Entities::Error ]
          ]
        end
        params do
          requires :data, type: Morpho::Entities::UserEmail
        end
        post do
          if current_user
            if current_user.login_locked?
              current_user.resend_unlock_token_email!

              present current_user, with: Morpho::Entities::User
            else
              render_method_not_allowed
            end
          else
            render_not_found
          end
        end
      end
    end
  end
end
