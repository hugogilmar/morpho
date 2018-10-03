module Morpho
  module Resources
    class Unlocks < ::Grape::API
      helpers Morpho::Grape::HTTPResponses, Morpho::Grape::UserUnlock

      namespace :unlocks do
        desc 'Request user unlock token' do
          success Morpho::Entities::User
        end
        params do
          requires :user, type: Morpho::Entities::User
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
