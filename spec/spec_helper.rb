require 'bundler/setup'

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'action_view'
require 'rspec-html-matchers'

require 'angular_form'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end

