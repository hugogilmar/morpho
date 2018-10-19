module Morpho
  module Helpers
    module UserPasswordReset
      protected

      def current_user
        @current_user ||= Morpho::User.find_by(params[:user])
      end
    end
  end
end
