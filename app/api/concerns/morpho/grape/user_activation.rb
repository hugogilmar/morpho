module Morpho
  module Grape
    module UserActivation
      extend ActiveSupport::Concern

      protected

      def current_user
        @current_user ||= Morpho::User.find_by(params[:user])
      end
    end
  end
end
