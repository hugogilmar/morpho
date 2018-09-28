require 'morpho/configurations/mailer'
require 'morpho/configurations/api'
require 'morpho/configurations/jwt'

module Morpho
  class Configuration
    attr_accessor :mailer
    attr_accessor :api
    attr_accessor :jwt

    attr_accessor :host

    def initialize
      self.host = ''

      self.mailer = Morpho::Configurations::Mailer.new
      self.api = Morpho::Configurations::API.new
      self.jwt = Morpho::Configurations::JWT.new
    end
  end
end
