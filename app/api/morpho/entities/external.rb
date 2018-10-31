module Morpho
  module Entities
    class External < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address', required: true }
      expose :provider, documentation: { type: 'string', desc: 'User authentication provider', required: true }
      expose :uid, documentation: { type: 'string', desc: 'User provider uid', required: true }
    end
  end
end
