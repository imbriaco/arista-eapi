require 'spec_helper'
require 'json'
require 'restclient'
require 'arista/eapi'

describe 'External request' do
  hostname = "local"
  user = "read"
  password = "read"

  it 'login' do
    response = Arista::EAPI::Switch.new(hostname, user, password, "http")
    puts response
  end

  it 'MockeAPI#enable' do
    switch = Arista::EAPI::Switch.new(hostname, user, password, "http")
    response = switch.run( ['enable', "show version"] )
    puts "client response: #{response}"
  end

#  it 'enable using RestClient' do
#    payload = {
#        "version" => 1,
#        "cmds" => [ "enable" ]
#      }
#
#    uri = 'http://read:read@local/command-api'
#    response = RestClient.post(uri, payload)
#    puts response
#    #expect(response).to eq '{}'
#  end
#
#  it 'show running' do
#    uri = URI('https://read:read@local/command-api/show-running')
#    response = JSON.load(Net::HTTP.get(uri))
#    puts response
#  end
#
#  it 'show runnin 2g' do
#    uri = URI('https://read:read@local/command-api/abc')
#    response = JSON.load(Net::HTTP.get(uri))
#    puts response
#  end
end
