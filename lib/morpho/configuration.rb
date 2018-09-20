module Morpho
  class Configuration
    attr_accessor :mailer_from
    attr_accessor :mailer_address
    attr_accessor :mailer_user_name
    attr_accessor :mailer_password
    attr_accessor :mailer_port
    attr_accessor :mailer_authentication
    attr_accessor :mailer_enable_starttls_auto

    def initialize
      @mailer_from = ''
      @mailer_address = ''
      @mailer_user_name = ''
      @mailer_password = ''
      @mailer_port = ''
      @mailer_authentication = ''
      @mailer_enable_starttls_auto = ''
    end
  end
end
