# frozen_string_literal: true

module Morpho
  module Cipher
    module_function

    def jwt_encode(payload, algorithm = Morpho.config.jwt.algorithm)
      ::JWT.encode(payload, Morpho.config.jwt.secret, algorithm)
    end

    def jwt_decode(token, algorithm = Morpho.config.jwt.algorithm)
      ::JWT.decode(token, Morpho.config.jwt.secret, true, algorithm: algorithm)
    end
  end
end
