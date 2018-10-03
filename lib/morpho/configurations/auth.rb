module Morpho
  module Configurations
    class Auth
      attr_accessor :failed_login_attempts_limit

      def initialize
        self.failed_login_attempts_limit = 0
      end
    end
  end
end
