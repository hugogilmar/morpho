module Morpho
  module Entities
    class Credentials < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address' }
      expose :password, documentation: { type: 'string', desc: 'User password' }
    end
  end
end
