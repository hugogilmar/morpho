module Morpho
  module Grape
    module UserRegistration
      extend ActiveSupport::Concern

      protected

      def register(user_params)
        user = Morpho::User.new(user_params)

        if user.save
          present user, with: Morpho::Entities::User
        else
          render_unprocessable_entity_detailed(user.errors)
        end
      end
    end
  end
end
