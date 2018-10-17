module Morpho
  module Entities
    class User < ::Morpho::Entities::Base
      root 'data', 'data'
      expose :email, documentation: { type: 'string', desc: 'User email address' }
    end
  end
end
