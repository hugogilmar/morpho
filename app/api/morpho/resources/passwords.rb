module Morpho
  module Resources
    class Passwords < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
        Morpho::Helpers::UserPasswordReset

      namespace :passwords do
        desc 'Request user reset password token' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::User)
        end
        params do
          requires :data, type: Morpho::Entities::UserEmail
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
