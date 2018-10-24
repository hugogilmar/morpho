module Morpho
  module Resources
    class Activations < ::Grape::API
      helpers Morpho::Helpers::HTTPResponses,
        Morpho::Helpers::UserActivation

      namespace :activations do
        desc 'Request user activation token' do
          success Morpho::Grape::DataWrapper.new(Morpho::Entities::User)
        end
        params do
          requires :user, type: Morpho::Entities::User
        end
        post do
          if current_user
            if !current_user.active?
              current_user.resend_activation_needed_email!

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
