module Morpho
  module Entities
    module SignIn
      class Success < ::Morpho::Entities::Base
        expose :data, using: ::Morpho::Entities::SignIn::AuthenticationToken
      end
    end
  end
end
