# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yabeda/gruf/version'

Gem::Specification.new do |spec|
  spec.name          = 'yabeda-gruf'
  spec.version       = Yabeda::Gruf::VERSION
  spec.authors       = ['kruczjak']
  spec.email         = ['jakub.kruczek@boostcom.no']

  spec.summary       = 'Yabeda exporter for gruf'
  spec.description   = 'Yabeda exporter for gruf gRPC server'
  spec.homepage      = 'https://boostcom.no'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gruf', '>= 2.7.0'
  spec.add_dependency 'yabeda'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
