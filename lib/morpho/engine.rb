module Morpho
  class Engine < ::Rails::Engine
    isolate_namespace Morpho
    engine_name 'morpho'

    initializer 'morpho', before: :load_config_initializers do |app|
    initializer 'morpho.migrations', before: :load_config_initializers do |app|
      config.paths['db/migrate'].expanded.each do |expanded_path|
        Rails.application.config.paths['db/migrate'] << expanded_path
        app.config.paths['db/migrate'] << expanded_path
      end
    end
  end
end
