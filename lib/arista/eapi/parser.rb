module Arista
  module EAPI
    class Parser
      def self.parse(command, body)
        parser_class = command.split.first.downcase.capitalize
        parser_method = command.gsub(/\s/, '_')

        parser = self.const_get(parser_class)

        if parser.respond_to?(parser_method.to_sym)
          parser.send(parser_method, body)
        else
          body
        end
      rescue NameError
        body
      end
    end
  end
end
