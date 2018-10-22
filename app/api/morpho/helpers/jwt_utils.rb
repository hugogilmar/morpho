module Morpho
  module Helpers
    module JWTUtils
      protected

      def current_user
        @current_user ||= Morpho::User.find_by(email: jwt_token[:email])
      rescue
        nil
      end

      def http_token
        @http_token ||= if request.headers[Morpho.config.jwt.header].present?
          request.headers[Morpho.config.jwt.header].split(' ').last
        end
      end

      def jwt_token
        @jwt_token ||= HashWithIndifferentAccess.new(jwt_decode(http_token).first)
      end

      def jwt_encode(payload)
        Morpho::Cipher.jwt_encode(payload)
      end

      def jwt_decode(token)
        begin
          return Morpho::Cipher.jwt_decode(token)
        rescue
          nil
        end
      end

      def user_payload(user)
        expires_at = Time.now.to_i + Morpho.config.jwt.expiration_time
        issued_at = Time.now.to_i

        { authentication_token: jwt_encode({ exp: expires_at, iat: issued_at, email: user.email }), expires_at: expires_at, refresh_token: user.refresh_token }
      end
    end
  end
end
