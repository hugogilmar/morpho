module Morpho
  module JWTActionController
    extend ActiveSupport::Concern

    protected

    def logged_in?
      !!current_user
    end

    def require_login
      render_unauthorized unless logged_in?
    end

    def render_bad_request
      render json: { message: I18n.t('morpho.api.messages.bad_request') }, status: 400 and return
    end

    def render_unauthorized
      render json: { message: I18n.t('morpho.api.messages.unauthorized') }, status: 401 and return
    end

    def render_forbidden
      render json: { message: I18n.t('morpho.api.messages.forbidden') }, status: 403 and return
    end

    def render_not_found
      render json: { message: I18n.t('morpho.api.messages.not_found') }, status: 404 and return
    end

    def render_unprocessable_entity(errors)
      render json: { message: I18n.t('morpho.api.messages.unprocessable_entity'), errors: errors }, status: 422 and return
    end

    def render_no_content
      render nothing: true, status: 204 and return
    end

    def login(email, password)
      user = User.find_by(email: email)

      unless user.nil?
        if user.valid_password?(password)
          render json: user_payload(user)
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
      expires_at = Time.now.to_i + 60 * 60
      issued_at = Time.now.to_i

      { token: jwt_encode({ exp: expires_at, iat: issued_at, email: user.email }), expires_at: expires_at }
    end
  end
end
