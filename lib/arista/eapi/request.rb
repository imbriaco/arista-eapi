module Arista
  module EAPI
    class Request
      attr_accessor :switch, :commands, :options

      def initialize(switch, commands, options = {})
        options[:format] ||= 'json'

        self.switch = switch
        self.commands = commands
        self.options = options
      end

      def payload
        @payload ||= JSON.generate({
          :jsonrpc => '2.0',
          :method  => 'runCmds',
          :id      => 1,
          :params  => {
            :version => 1,
            :cmds    => commands,
            :format  => options[:format]
          },
        })
      end

      def execute
        Arista::EAPI::Response.new(commands, RestClient.post(switch.url, payload))
      end
    end
  end
end