ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'fake_braintree'
require 'webmock/test_unit'

class ActiveSupport::TestCase
  fixtures :all

  FakeBraintree.activate!
  stub_request(:get, "http://127.0.0.1:54433/__identify__")
    .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'})
    .to_return(:status => 200, :body => "", :headers => {})
end
