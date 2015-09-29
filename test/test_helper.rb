require 'simplecov'
require 'coveralls'

SimpleCov.start
Coveralls.wear!

require 'minitest/autorun'
require 'minitest/reporters'
require 'rails'
require "rails/generators/test_case"
require File.expand_path('../../lib/webhookr-vero.rb', __FILE__)

if RUBY_VERSION >= "1.9"
  MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)
end
