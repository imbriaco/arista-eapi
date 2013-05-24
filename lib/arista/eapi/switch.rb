module Arista
  module EAPI
    class Switch
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
        run!('show interfaces')
        attributes[:interfaces]
      end

      def version
        run!('show version')
      end

      def update_attributes!(results)
        results.each { |result| attributes.merge!(result) if result.is_a?(Hash) }
      end

      # Public: Run the 
      #
      # options - Options to pass to the eAPI call.
      #           :format - The format for the eAPI response. Accepts the strings
      #                     "json" or "text". (Defaults to json)
      #
      def run(commands, options={})
        request = Arista::EAPI::Request.new(self, commands, options)
        self.update_attributes!(request.execute.results)
      end
    end
  end
end