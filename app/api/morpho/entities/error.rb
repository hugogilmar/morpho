module Morpho
  module Entities
    class Error < ::Grape::Entity
      expose :message, documentation: { type: 'string', desc: 'Error standard message', required: true }
      expose :errors, safe: true, documentation: { type: 'object', desc: 'Error message details' }
    end
  end
end
