require 'morpho/loader'
require 'morpho/engine'
require 'morpho/version'
require 'morpho/configuration'
require 'morpho/validators/contain_number_validator'
require 'morpho/validators/contain_uppercase_validator'
require 'morpho/validators/contain_symbol_validator'

module Morpho
  class << self
    attr_writer :config

    def configure
      yield config
    end

    def config
      @config ||= Morpho::Configuration.new
    end
  end
end
