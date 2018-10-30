module Morpho
  module Entities
    class RefreshToken < ::Morpho::Entities::Base
      expose :refresh_token, documentation: { type: 'string', desc: 'User refresh token', required: true }
    end
  end
end
