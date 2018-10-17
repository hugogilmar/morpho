module Morpho
  module Entities
    class UserSignUp < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address' }
      expose :password, documentation: { type: 'string', desc: 'User password' }
      expose :password_confirmation, documentation: { type: 'string', desc: 'User password confirmation' }
    end
  end
end
