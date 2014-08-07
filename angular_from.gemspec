# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'angular_form/version'

Gem::Specification.new do |spec|
  spec.name          = 'angular_form'
  spec.version       = AngularForm::VERSION
  spec.authors       = ['Radoslav Stankov']
  spec.email         = ['rstankov@gmail.com']
  spec.description   = %q()
  spec.summary       = %q()
  spec.homepage      = 'https://github.com/RStankov/rails-angular-form-builder'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 4.0'
  spec.add_runtime_dependency 'actionpack', '>= 4.0'
  spec.add_runtime_dependency 'actionview', '>= 4.0'
  spec.add_runtime_dependency 'railties', '>= 4.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '3.0'
  spec.add_development_dependency 'rspec-mocks', '3.0'
  spec.add_development_dependency 'rspec-html-matchers', '0.6.1'
  spec.add_development_dependency 'capybara', '2.4.1'
  spec.add_development_dependency 'coveralls'
end


