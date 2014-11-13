# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arista/eapi/version'

Gem::Specification.new do |spec|
  spec.name          = "arista-eapi"
  spec.version       = Arista::EAPI::VERSION
  spec.authors       = ["Mark Imbriaco"]
  spec.email         = ["mark@imbriaco.com"]
  spec.description   = %q{Client for Arista Networks eAPI}
  spec.summary       = %q{Arista eAPI Client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "rest-client"
  spec.add_dependency 'json', '~> 1.8'
end
