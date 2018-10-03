module Morpho
  module Configurations
    class Mailer
      attr_accessor :from
      attr_accessor :address
      attr_accessor :user_name
      attr_accessor :password
      attr_accessor :port
      attr_accessor :authentication
      attr_accessor :enable_starttls_auto

      def initialize
        self.from = ''
        self.address = ''
        self.user_name = ''
        self.password = ''
        self.port = ''
        self.authentication = ''
        self.enable_starttls_auto = ''
      end
    end
  end
end
