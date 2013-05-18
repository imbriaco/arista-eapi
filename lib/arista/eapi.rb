
require 'cgi'
require 'json'
require 'restclient'

require 'arista/eapi/format'
require 'arista/eapi/request'
require 'arista/eapi/response'
require 'arista/eapi/switch'
require 'arista/eapi/version'

module Arista
  module EAPI
    # Public: Determine the eAPI supported format based on the commands. 
    #
    # options - List of commands to check format options for.
    #
    # Examples
    #
    #   Arista::EAPI.format_for('show vlan') 
    #   #=> 'json'
    #   Arista::EAPI.format_for('show vlan', 'show lldp neighbors') 
    #   #=> text
    #
    # Returns json if all commands support JSON output, otherwise returns text.
    def self.format_for(*commands)
      (commands - Arista::EAPI::Format::JSON_COMMANDS).size > 0 ? 'text' : 'json'
    end
  end
end
