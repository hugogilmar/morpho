$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'morpho/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'morpho'
  s.version = Morpho::VERSION
  s.authors = ['Hugo Gilmar Erazo']
  s.email = ['hugogilmar@gmail.com']
  s.homepage = 'https://github.com/hugogilmar/morpho'
  s.summary = 'Morpho Core.'
  s.description = 'Skeleton rails engine for modular development.'
  s.license = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2'

  s.add_dependency 'draper', '~> 3.0'
  s.add_dependency 'sorcery', '~> 0.12'
  s.add_dependency 'jwt', '~> 1.5'
  s.add_dependency 'validates_email_format_of', '~> 1.6'
  s.add_dependency 'flash_rails_messages', '~> 1.0'
  s.add_dependency 'simple_form', '~> 4.0'
  s.add_dependency 'grape', '~> 1.1'
  s.add_dependency 'grape-entity', '~> 0.7'
  s.add_dependency 'grape-swagger', '~> 0.31'
  s.add_dependency 'grape-swagger-entity', '~> 0.3'
  s.add_dependency 'grape-swagger-representable', '~> 0.2'
  s.add_dependency 'rails-i18n', '~> 5.1'
  s.add_dependency 'reform', '~> 2.2'
  s.add_dependency 'reform-rails', '~> 0.1'
  s.add_dependency 'trailblazer-operation', '~> 0.4'

  s.add_development_dependency 'sqlite3', '> 0'
  s.add_development_dependency 'rubocop', '> 0'
  s.add_development_dependency 'simplecov', '> 0'
end
