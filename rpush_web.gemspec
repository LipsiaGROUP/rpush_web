$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rpush_web/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rpush_web"
  s.version     = RpushWeb::VERSION
  s.authors     = ["Mada Aryakusumah"]
  s.email       = ["lokermada@gmail.com"]
  s.homepage    = "http://github.com"
  s.summary     = "Web UI for rpush"
  s.description = "Web UI for rpush lib"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "carrierwave"
  s.add_dependency "rpush"
  s.add_dependency 'kaminari'

  s.add_development_dependency "sqlite3"
end