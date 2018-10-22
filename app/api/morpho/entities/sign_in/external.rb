module Morpho
  module Entities
    module SignIn
      class External < ::Morpho::Entities::Base
        expose :email, documentation: { type: 'string', desc: 'User email address' }
        expose :name, documentation: { type: 'string', desc: 'User name' }
        expose :provider, documentation: { type: 'string', desc: 'User authentication provider' }
        expose :uid, documentation: { type: 'string', desc: 'User provider uid' }
      end
    end
  end
end
