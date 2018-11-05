module Morpho
  module JWT
    class Decode
      def self.new(token)
        begin
          Morpho::Cipher.jwt_decode(token)
        rescue
          nil
        end
      end
    end
  end
end
