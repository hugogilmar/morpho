# frozen_string_literal: true

module Morpho
  module JWT
    class Token
      def self.new(authentication_token)
        begin
          token = ::Morpho::JWT::Decode.new(authentication_token)

          HashWithIndifferentAccess.new(token.first)
        rescue
          HashWithIndifferentAccess.new
        end
      end
    end
  end
end
