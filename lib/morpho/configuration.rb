require 'morpho/configurations/mailer'
require 'morpho/configurations/api'
require 'morpho/configurations/jwt'
require 'morpho/configurations/auth'

module Morpho
  class Configuration
    attr_accessor :host
    attr_accessor :protocol

    attr_accessor :mailer
    attr_accessor :api
    attr_accessor :jwt
    attr_accessor :auth

    def initialize
      self.host = ''
      self.protocol = ''

      self.mailer = Morpho::Configurations::Mailer.new
      self.api = Morpho::Configurations::API.new
      self.jwt = Morpho::Configurations::JWT.new
      self.auth = Morpho::Configurations::Auth.new
    end
  end
end
