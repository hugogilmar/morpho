module Morpho
  module JWTGrape
    extend ActiveSupport::Concern

    def logged_in?
      !!current_user
    end

    def require_login
      render_unauthorized unless logged_in?
    end

    def render_bad_request
      error!({ message: I18n.t('morpho.api.messages.bad_request') }, 400)
    end

    def render_unauthorized
      error!({ message: I18n.t('morpho.api.messages.unauthorized') }, 401)
    end

    def render_forbidden
      error!({ message: I18n.t('morpho.api.messages.forbidden') }, 403)
    end

    def render_not_found
      error!({ message: I18n.t('morpho.api.messages.not_found') }, 404)
    end

    def render_unprocessable_entity(errors)
      error!({ message: I18n.t('morpho.api.messages.unprocessable_entity'), errors: errors }, 422)
    end

    def render_no_content
      body false
    end

    def login(email, password)
      user = User.find_by(email: email)

      unless user.nil?
        if user.valid_password?(password)
          token = user_payload(user)

          present token, with: Morpho::Entities::AuthenticationToken
        else
          render_unauthorized
        end
      else
        render_unauthorized
      end
    end

    def register(user_attributes)
      user = Morpho::User.new(user_attributes)

      if user.save
        present user, with: Morpho::Entities::User
      else
        render_unprocessable_entity(user.errors)
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
