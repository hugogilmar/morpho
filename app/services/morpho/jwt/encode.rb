# frozen_string_literal: true

module Morpho
  module JWT
    class Encode
      def self.new(payload)
        begin
          Morpho::Cipher.jwt_encode(payload)
        rescue
          nil
        end
      end
    end
  end
end
