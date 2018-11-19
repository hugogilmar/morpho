# frozen_string_literal: true

module Morpho
  module JWT
    class AuthenticationToken
      def self.new(request)
        if request.headers[Morpho.config.jwt.header].present?
          request.headers[Morpho.config.jwt.header].split(' ').last
        else
          nil
        end
      end
    end
  end
end
