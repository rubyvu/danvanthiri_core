$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "danvanthiri_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "danvanthiri_core"
  s.version     = DanvanthiriCore::VERSION
  s.authors     = ["Ngoc Vu"]
  s.email       = ["ngoc@digifutura.com"]
  s.homepage    = "http://www.Danvanthiri.com"
  s.summary     = "DanvanthiriCore."
  s.description = "DanvanthiriCore."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"
  s.add_dependency "pg"
  s.add_dependency "devise"
  s.add_dependency "friendly_id"
  s.add_dependency "elasticsearch-model"
  s.add_dependency 'elasticsearch-rails'
  s.add_dependency 'bonsai-elasticsearch-rails'
end