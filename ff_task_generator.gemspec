# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ff_task_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'ff_task_generator'
  spec.version       = FfTaskGenerator::VERSION
  spec.authors       = ['Gleb Sinyavsky']
  spec.email         = ['zhulik.gleb@gmail.com']

  spec.summary       = %q{XML Task generator for Filter Forge 4 CMD renderer}
  spec.description   = %q{XML Task generator for Filter Forge 4 CMD renderer}
  spec.homepage      = 'https://github.com/RoadAR/ff_task_generator'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
end
