$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "clicksign/webhooks/version"

Gem::Specification.new do |spec|
  spec.name        = "clicksign-webhooks"
  spec.version     = Clicksign::Webhooks::VERSION
  spec.authors     = ["Francisco Martins"]
  spec.email       = ["franciscomxs@gmail.com"]
  spec.homepage    = "https://github.com/NexoosBR/clicksign-webhooks"
  spec.summary     = "Clicksign webhook engine for rails apps"
  spec.license     = "MIT"
  spec.test_files = Dir["spec/**/*"]

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "> 4"
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'dotenv-rails', '~> 2.5'
end
