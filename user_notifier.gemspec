$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "user_notifier/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "user_notifier"
  s.version     = UserNotifier::VERSION
  s.authors     = ["Diogo Biazus"]
  s.email       = ["diogo@biazus.me"]
  s.homepage    = "https://github.com/diogob/user_notifier"
  s.summary     = "Simple pattern for keeping track of messages sent to users based on model events with different templates."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_development_dependency 'rspec-rails'

  s.add_development_dependency "pg"
end
