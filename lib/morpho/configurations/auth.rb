module Morpho
  module Configurations
    class Auth
      attr_accessor :failed_login_attempts_limit
      attr_accessor :password_minimum_length
      def initialize
        self.failed_login_attempts_limit = 0
        self.password_minimum_length = 8
      end
    end
  end
end
