module Morpho
  module Entities
    module SignIn
      class AuthenticationToken < ::Morpho::Entities::Base
        expose :token, documentation: { type: 'string', desc: 'User authentication token', required: true }
        expose :expires_at, documentation: { type: 'string', desc: 'Authentication token expiration date in millis', required: true }
      end
    end
  end
end
