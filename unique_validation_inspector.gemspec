# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "unique_validation_inspector/version"

Gem::Specification.new do |spec|
  spec.name          = "unique_validation_inspector"
  spec.version       = UniqueValidationInspector::VERSION
  spec.authors       = ["Igor Khomenko"]
  spec.email         = ["khomenkoigor@gmail.com"]

  spec.summary       = "A Rake task that helps you find unique validations in models that do not have proper DB indexes."
  spec.description   = "A Rake task investigates the application's models definition, then tells you unique validations that do not have DB indexes."
  spec.homepage      = "https://github.com/soulfly/unique_validation_inspector"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ['>= 3.0.0']

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "activerecord", ['>= 3.0.0']
  spec.add_development_dependency "sqlite3", "~> 1.6.0"
end
