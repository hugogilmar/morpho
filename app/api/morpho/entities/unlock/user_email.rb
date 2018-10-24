module Morpho
  module Entities
    module Unlock
      class UserEmail < ::Morpho::Entities::Base
        expose :email, documentation: { type: 'string', desc: 'User email address' }
      end
    end
  end
end
