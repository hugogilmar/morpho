module Morpho
  module Entities
    class AuthenticationToken < ::Morpho::Entities::Base
      expose :authentication_token, documentation: { type: 'string', desc: 'User authentication token', required: true }
      expose :expires_at, documentation: { type: 'string', desc: 'Authentication token expiration date in millis', required: true }
      expose :refresh_token, documentation: { type: 'string', desc: 'User refresh token', required: true }
    end
  end
end
