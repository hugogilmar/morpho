module Morpho
  module Entities
    class AuthenticationToken < ::Grape::Entity
      expose :token, documentation: { type: 'string', desc: 'User authentication token', required: true }
      expose :expires_at, documentation: { type: 'string', desc: 'Authentication token expiration date in millis', required: true }
    end
  end
end
