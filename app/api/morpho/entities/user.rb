module Morpho
  module Entities
    class User < Grape::Entity
      expose :email, documentation: { type: 'string', desc: 'User email address' }
    end
  end
end
