# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'undercover/gem_version'

Gem::Specification.new do |spec|
  spec.name          = 'danger-undercover'
  spec.version       = Undercover::VERSION
  spec.authors       = %w[Nimble rafayet-monon]
  spec.email         = %w[dev@nimblehq.co rafayet@nimblehq.co]
  spec.description   = 'Show undercover report to PRs'
  spec.summary       = 'A Danger plugin for Undercover gem'
  spec.homepage      = 'https://github.com/nimblehq/danger-undercover'
  spec.license       = 'MIT'
  spec.metadata      = { 'rubygems_mfa_required' => 'true' }

  spec.required_ruby_version = '>= 2.7'
  spec.files                 = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths         = ['lib']

  spec.add_runtime_dependency 'danger-plugin-api', '~> 1.0'

  # General ruby development
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  # Testing support
  spec.add_development_dependency 'rspec'

  # Linting code and docs
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'yard'

  # Makes testing easy via `bundle exec guard`
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'

  # If you want to work on older builds of ruby
  spec.add_development_dependency 'listen'

  # This gives you the chance to run a REPL inside your tests
  # via:
  #
  #    require 'pry'
  #    binding.pry
  #
  # This will stop test execution and let you inspect the results
  spec.add_development_dependency 'pry'
end
