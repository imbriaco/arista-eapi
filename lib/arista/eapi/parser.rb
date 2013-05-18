class Arista::EAPI::Parser
  def self.parse(command, body)
    parser_class = command.split.first.downcase.capitalize
    parser_method = command.gsub(/\s/, '_')

    parser = self.const_get(parser_class)
    parser.send(parser_method, body) if parser.respond_to?(parser_method.to_sym)
  rescue NameError
    body
  end
end
