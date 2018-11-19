# frozen_string_literal: true

module Morpho
  module Configurations
    class API
      attr_accessor :title
      attr_accessor :description
      attr_accessor :entities
      attr_accessor :versions

      def initialize
        self.title = ''
        self.description = ''
        self.entities = []
        self.versions = []
      end

      def register_entity(entity)
        self.entities << entity
      end

      def register_entities
      end

      def register_version(version)
        self.versions << version
      end

      def register_versions
      end
    end
  end
end
