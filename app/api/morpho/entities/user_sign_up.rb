# frozen_string_literal: true

module Morpho
  module Entities
    class UserSignUp < ::Morpho::Entities::Base
      expose :email, documentation: { type: 'string', desc: 'User email address', required: true }
      expose :password, documentation: { type: 'string', desc: 'User password', required: true }
      expose :password_confirmation, documentation: { type: 'string', desc: 'User password confirmation', required: true }
    end
  end
end
