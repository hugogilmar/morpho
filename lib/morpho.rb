require 'morpho/loader'
require 'morpho/engine'
require 'morpho/version'
require 'morpho/configuration'

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
