module Morpho
  module Configurations
    class JWT
      attr_accessor :secret
      attr_accessor :algorithm
      attr_accessor :header

      def initialize
        self.secret = ''
        self.algorithm = ''
        self.header = ''
      end
    end
  end
end
