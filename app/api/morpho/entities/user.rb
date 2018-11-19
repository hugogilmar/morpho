# frozen_string_literal: true

module Morpho
  module Entities
    class User < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address' }
    end
  end
end
