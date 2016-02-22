$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dhanvantri_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dhanvantri_core"
  s.version     = DhanvantriCore::VERSION
  s.authors     = ["Ngoc Vu"]
  s.email       = ["ngoc@digifutura.com"]
  s.homepage    = "http://www.Dhanvantri.com"
  s.summary     = "DhanvantriCore."
  s.description = "DhanvantriCore."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"
  s.add_dependency "pg"
  s.add_dependency "devise"
  s.add_dependency "friendly_id"
end