$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "morpho/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "morpho"
  s.version     = Morpho::VERSION
  s.authors     = ["Hugo Gilmar Erazo"]
  s.email       = ["hugogilmar@gmail.com"]
  s.homepage    = "https://github.com/hugogilmar/morpho"
  s.summary     = "Morpho Core."
  s.description = "Skeleton rails engine for modular development."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.1"

  s.add_development_dependency "sqlite3"
end
