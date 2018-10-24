module Morpho
  module Entities
    class UserEmail < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address' }
    end
  end
end
