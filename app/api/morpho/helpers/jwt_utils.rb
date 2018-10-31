module Morpho
  module Helpers
    module JWTUtils
      protected

      def logged_in?
        !!current_user
      end

      def require_login
        render_unauthorized unless logged_in?
      end

      def current_user
        @current_user ||= Morpho::User.find_by(email: token[:email])
      rescue
        nil
      end

      def authentication_token
        @authentication_token ||= ::Morpho::JWT::AuthenticationToken.new(request)
      rescue
        nil
      end

      def token
        @token ||= ::Morpho::JWT::Token.new(authentication_token)
      rescue
        nil
      end
    end
  end
end
