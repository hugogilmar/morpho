module Morpho
  module Entities
    class User < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address' }
    end
  end
end
