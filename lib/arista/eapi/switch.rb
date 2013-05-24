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

      # Public: Runs a single command and returns the first result.
      #
      # options - Options to pass to the eAPI call.
      #           :format - The format for the eAPI response. Accepts the strings
      #                     "json" or "text". (Defaults to json)
      #
      # Examples
      #
      #   switch.run!('show version')
      #   #=> {:model_name=>"DCS-7048T-A-R", :internal_version=>"4.12.0-1244071.EOS4120", :system_mac_address=>"00:1c:73:16:c2:c8", :serial_number=>"redacted", :mem_total=>4009152, :bootup_timestamp=>1368735672.690161, :mem_free=>1848284, :version=>"4.12.0", :architecture=>"i386", :internal_build_id=>"c25ec8ea-cb8f-40a8-af0b-d11eaa94d57c", :hardware_revision=>"01.04"}
      #
      def run!(command, options={})
        run([command], options).first
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