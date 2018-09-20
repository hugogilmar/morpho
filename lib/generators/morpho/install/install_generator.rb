class Morpho::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def install
    copy_file 'config/initializers/morpho.rb', 'config/initializers/morpho.rb'
  end
end
