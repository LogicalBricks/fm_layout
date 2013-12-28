# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fm_layout/version'

Gem::Specification.new do |gem|
  gem.name          = "fm_layout"
  gem.version       = FmLayout::VERSION
  gem.authors       = ["Hermes Ojeda Ruiz"]
  gem.email         = ["hermes.ojeda@logicalbricks.com"]
  gem.description   = %q{Generador del Layout para la conexión con Facturación Moderna a través de un DSL}
  gem.summary       = %q{Generador del Layout para la conexión con Facturación Moderna a través de un DSL}
  gem.homepage      = ""
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
