# spec/spec_helper.rb
require 'rspec'
require 'webmock/rspec'
require 'arista/mockeapi'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, /local/).to_rack(MockEAPI)
    stub_request(:post, /local/).to_rack(MockEAPI)
  end
end
