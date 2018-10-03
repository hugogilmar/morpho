module Morpho
  module Configurations
    class JWT
      attr_accessor :secret
      attr_accessor :algorithm
      attr_accessor :header
      attr_accessor :expiration_time

      def initialize
        self.secret = ''
        self.algorithm = ''
        self.header = ''
        self.expiration_time = 0
      end
    end
  end
end
