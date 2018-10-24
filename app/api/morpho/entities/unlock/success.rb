module Morpho
  module Entities
    module Unlock
      class Success < ::Morpho::Entities::Base
        expose :data, using: ::Morpho::Entities::User
      end
    end
  end
end
