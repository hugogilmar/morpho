module Morpho
  module Helpers
    module UserUnlock
      protected

      def current_user
        @current_user ||= Morpho::User.find_by(params[:data])
      end
    end
  end
end
