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

      attr_accessor :code, :response, :results

      def initialize(body)
        self.response = JSON.parse(body)

        if response['error']
          code = response['error']['code']
          raise code < 0 ? Exception.new(response['message']) : ERROR_CODES[code]
        end
        
        self.results = convert_hash_keys(response['result'])
      end

      private

      def symbolize(string)
        string.
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
