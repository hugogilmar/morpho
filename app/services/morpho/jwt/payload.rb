module Morpho
  class JWT::Payload
    def self.new(user)
      expires_at = Time.now.to_i + Morpho.config.jwt.expiration_time
      issued_at = Time.now.to_i
      token = ::Morpho::JWT::Encode.new({ exp: expires_at, iat: issued_at, email: user.email })

      { authentication_token: token, expires_at: expires_at, refresh_token: user.refresh_token }
    end
  end
end
