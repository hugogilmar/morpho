module Morpho
  class Engine < ::Rails::Engine
    isolate_namespace Morpho
    engine_name 'morpho'
  end
end
