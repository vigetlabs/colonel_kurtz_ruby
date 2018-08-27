# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'colonel_kurtz/version'

Gem::Specification.new do |spec|
  spec.name          = "colonel_kurtz_ruby"
  spec.version       = ColonelKurtz::VERSION
  spec.authors       = ["Viget"]
  spec.email         = ["developers@viget.com"]

  spec.summary       = "Ruby wrapper for Colonel Kurtz data"
  spec.description   = "Colonel Kurtz Ruby is a lightweight shim between the JSON data that Colonel Kurtz (https://github.com/vigetlabs/colonel-kurtz) creates and POROs."
  spec.homepage      = "https://github.com/vigetlabs/colonel_kurtz_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",       "~> 1.8"
  spec.add_development_dependency "rake",          "~> 10.0"
  spec.add_development_dependency "rspec",         "~> 3.2"
  spec.add_development_dependency "pry",           "~> 0.10"
  spec.add_development_dependency "activesupport", "~> 4.2"
  spec.add_development_dependency "activerecord",  ">= 1.0"

  spec.add_development_dependency "codeclimate-test-reporter"
end
