module Arista
  module EAPI
    module Error
      class GeneralError < Exception ; end
      class InternalException < Exception ; end
      class InvalidCommand < Exception; end
      class TextOnly < Exception; end
      class IncomptibleCommand < Exception; end
      class AmbiguousCommand < Exception; end
    end

    class Response
      ERROR_CODES = {
        1000 => Arista::EAPI::Error::GeneralError,
        1001 => Arista::EAPI::Error::InternalException,
        1002 => Arista::EAPI::Error::InvalidCommand,
        1003 => Arista::EAPI::Error::TextOnly,
        1004 => Arista::EAPI::Error::IncomptibleCommand,
        1005 => Arista::EAPI::Error::AmbiguousCommand
      }

      PARSERS = [ Arista::EAPI::Parser::Show ]

      attr_accessor :code, :response, :results

      def initialize(commands, body)
        self.response = JSON.parse(body)
        self.results = []

        if response['error']
          code = response['error']['code']
          raise code < 0 ? Exception.new(response['message']) : ERROR_CODES[code]
        end

        commands.each_with_index do |cmd, idx|
          output = response['result'][idx]['output']
          parsed = Arista::EAPI::Parser.parse(cmd, output)
          results << convert_hash_keys(parsed)
        end

        results
      end

      private

      def symbolize(obj)
        obj.is_a?(Symbol) ? obj :
          obj.
            gsub(/\//, '_').
            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            downcase.
            to_sym
      end

      def convert_hash_keys(value)
        case value
          when Array
            value.map { |v| convert_hash_keys(v) }
          when Hash
            Hash[value.map { |k, v| [symbolize(k), convert_hash_keys(v)] }]
          else
            value
         end
      end    
    end
  end
end
