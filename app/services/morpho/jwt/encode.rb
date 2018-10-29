module Morpho
  class JWT::Encode
    def self.new(payload)
      #begin
        Morpho::Cipher.jwt_encode(payload)
      #nd
    end
  end
end
