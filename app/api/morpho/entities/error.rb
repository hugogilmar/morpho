module Morpho
  module Entities
    class Error < ::Grape::Entity
      expose :message, documentation: { type: 'string', desc: 'Error standard message', required: true }
      expose :errors, safe: true, documentation: { type: 'string', desc: 'Error message details', is_array: true }
    end
  end
end
