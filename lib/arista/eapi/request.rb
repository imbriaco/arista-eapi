class Arista::EAPI::Request
  attr_accessor :switch, :commands

  def initialize(switch, *commands)
    self.switch = switch
    self.commands = commands
  end

  def payload
    @payload ||= JSON.generate({
      :jsonrpc => '2.0',
      :method  => 'runCmds',
      :id      => 1,
      :params  => {
        :version => 1,
        :cmds    => commands,
        :format  => Arista::EAPI.format_for(commands)
      },
    })
  end

  def execute
    Arista::EAPI::Response.new(RestClient.post(switch.url, payload))
  end

  def self.execute!(switch, *commands)
    req = self.new(switch, *commands)
    req.execute
  end
end