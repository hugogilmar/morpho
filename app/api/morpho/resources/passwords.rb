module Morpho
  module Resources
    class Passwords < ::Grape::API
      helpers do
        Morpho::Grape::HTTPResponses
        Morpho::Grape::UserPasswordReset
      end

      namespace :passwords do
        desc 'Request user reset password token' do
          success Morpho::Entities::User
        end
        params do
          requires :user, type: Morpho::Entities::User
        end
        post do
          if current_user
            current_user.deliver_reset_password_instructions!

            present current_user, with: Morpho::Entities::User
          else
            render_not_found
          end
        end
      end
    end
  end
end
