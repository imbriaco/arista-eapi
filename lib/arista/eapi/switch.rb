class Arista::EAPI::Switch
  attr_accessor :hostname, :user, :password, :protocol, :url, :attributes

  def initialize(hostname, user, password, protocol = 'https')
    self.attributes = {}
    self.hostname = hostname
    self.user = user
    self.password = password
    self.protocol = protocol

    userpass = [ CGI.escape(user), CGI.escape(password) ].join(':')
    self.url = "#{protocol}://#{userpass}@#{hostname}/command-api"
  end

  def interfaces
    run('show interfaces') unless attributes[:interfaces]
    attributes[:interfaces]
  end

  def version
    run('show version') unless attributes[:version]
    attributes[:version]
  end

  def update_attributes!(results)
    results.each { |result| attributes.merge!(result) }
  end

  def run(*commands)
    request = Arista::EAPI::Request.new(self, *commands)
    self.update_attributes!(request.execute.results)
  end
end