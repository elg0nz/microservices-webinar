ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'fake_braintree'
require 'webmock/test_unit'

class ActiveSupport::TestCase
  fixtures :all

  FakeBraintree.activate!
end
