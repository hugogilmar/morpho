module Morpho
  class JWT::AuthenticationToken
    def self.new(request)
      if request.headers[Morpho.config.jwt.header].present?
        request.headers[Morpho.config.jwt.header].split(' ').last
      else
        nil
      end
    end
  end
end
