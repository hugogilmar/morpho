module Morpho
  module Grape
    module JWTAuthentication
      extend ActiveSupport::Concern

      protected

      def logged_in?
        !!current_user
      end

      def require_login
        render_unauthorized unless logged_in?
      end

      def login(user_params)
        user = User.find_by(email: user_params[:email])

        if user
          if user.active?
            if !user.login_locked?
              if user.valid_password?(user_params[:password])
                token = user_payload(user)

                present token, with: Morpho::Entities::AuthenticationToken
              else
                user.register_failed_login!
                render_unauthorized
              end
            else
              render_unauthorized
            end
          else
            render_unauthorized
          end
        else
          render_unauthorized
        end
      end

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
        JWT.encode(payload, Morpho.config.jwt.secret, Morpho.config.jwt.algorithm)
      end

      def jwt_decode(token)
        begin
          return JWT.decode(token, Morpho.config.jwt.secret, true, { algorithm: Morpho.config.jwt.algorithm })
        rescue
          nil
        end
      end

      def user_payload(user)
        expires_at = Time.now.to_i + Morpho.config.jwt.expiration_time
        issued_at = Time.now.to_i

        { token: jwt_encode({ exp: expires_at, iat: issued_at, email: user.email }), expires_at: expires_at }
      end
    end
  end
end
