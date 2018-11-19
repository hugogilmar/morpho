# frozen_string_literal: true

module Morpho
  module Entities
    class UserEmail < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address', required: true }
    end
  end
end
