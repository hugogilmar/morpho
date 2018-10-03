module Morpho
  module Grape
    module UserUnlock
      extend ActiveSupport::Concern

      protected

      def current_user
        @current_user ||= Morpho::User.find_by(params[:user])
      end
    end
  end
end
