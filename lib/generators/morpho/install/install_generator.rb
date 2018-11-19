# frozen_string_literal: true

class Morpho::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def install
    copy_file 'config/initializers/morpho.rb', 'config/initializers/morpho.rb'
    copy_file 'app/api/morpho/api.rb', 'app/api/morpho/api.rb'
    copy_file '.env', '.env'
  end
end
