# frozen_string_literal: true

module Morpho
  module Entities
    class Message < ::Morpho::Entities::Base
      expose :content, documentation: { type: 'string', desc: 'Message content' }
    end
  end
end
