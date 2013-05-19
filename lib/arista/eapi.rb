
require 'cgi'
require 'json'
require 'restclient'

require 'arista/eapi/parser'
require 'arista/eapi/parser/show'
require 'arista/eapi/request'
require 'arista/eapi/response'
require 'arista/eapi/switch'
require 'arista/eapi/version'

module Arista
  module EAPI
    JSON_COMMANDS = [
      'show aliases',
      'show interfaces',
      'show interfaces counters',
      'show interfaces counters discards',
      'show interfaces status',
      'show interfaces switchport vlan mapping',
      'show ip interface',
      'show ipv6 interface',
      'show mac address-table',
      'show mac address-table aging-time',
      'show management api http-commands',
      'show management api http-commands certificate',
      'show monitor server-failure history',
      'show monitor server-failure servers',
      'show monitor session',
      'show privilege',
      'show sflow',
      'show sflow interfaces',
      'show spanning-tree topology status',
      'show version',
      'show version license',
      'show vlan',
      'show vlan trunk group',
    ]


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
      (commands.flatten - JSON_COMMANDS).size > 0 ? 'text' : 'json'
    end
  end
end
