# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bipbop/version'

Gem::Specification.new do |spec|
  spec.name          = "bipbop-client"
  spec.version       = Bipbop::Client::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Otavio Carvalho"]
  spec.email         = ["otaviolcarvalho@gmail.com"]
  spec.summary       = "Library for communicating with BIPBOP"
  spec.description   = "Library for communicating with BIPBOP"
  spec.homepage      = "https://github.com/OTATA/bipbop-ruby"
  spec.license       = "MIT"

  spec.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = "lib"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
