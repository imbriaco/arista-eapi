# TODO: verify ssh key on input
# require 'sshkey'

class MockCli
  @@configure = ['username', 'show']
  @@default= ['enable']
  @@enable = ['configure', 'show']

  def initialize()
    @running_config = []
    @default = true
    @enable = false
    @configure = false
  end

  def run(inputs=[])
    # Simplify way of getting the 'command', this should be parse as an
    # expression. Right now first word is the command, anything else follow
    # is the parameter
    tokens = tokenize(inputs.first)
    if valid_input?(tokens.first)
      first = tokens.shift
      self.send first, inputs.first
    else
      invalid_input(tokens.first)
    end
  end

  def tokenize(input)
    input.split
  end

  def successful
    ''
  end

  def invalid_input(input)
    'Invalid input'
  end

  def invalid_command(input)
    'Incomplete command'
  end

  def show(input)
    standard = /show[\s]+([a-zA-Z\-]+)/.match(input)
    if standard
      case
      when standard[1] == 'running-config'
        return @running_config
      when standard[1] == 'version'
        return "version"
      else
        return invalid_command(input)
      end
    else
      invalid_input(input)
    end
  end

  def username(input)
    # Regex for now. CLI parsing is preferred, WIP in treetop branch
    standard = /username[\s]+([a-zA-Z\-0-9]+)[\s]+role[\s]+([a-zA-Z\-]+)[\s]+secret[\s]+([\d])+[\s]+(.*)/.match(input)
    sshkey = /username[\s]+([a-zA-Z\-]+)[\s]+sshkey[\s]+(.*)/.match(input)

    if standard
      @running_config << input
      return successful
    elsif sshkey
      @running_config << input
      return successful
    else
      invalid_command(input)
    end
  end

  def default?
    return @default
  end

  def enable?
    return @enable
  end

  def configure?
    return @configure
  end

  def default(*p)
    @enable = false
    @configure = false
    @default = true
    return successful
  end

  def enable(*p)
    @enable = true
    @configure = false
    @default = false
    return successful
  end

  def configure(*p)
    @enable = false
    @configure = true
    @default = false
    return successful
  end

  def valid_input?(input)
    #puts "-------------------------------"
    #puts "DEBUG: input #{input}"
    #puts "DEBUG: default #{default?}"
    #puts "DEBUG: enable #{enable?}"
    #puts "DEBUG: configure #{configure?}"
    #puts "-------------------------------"

    case
    when default?
      if @@default.include?(input)
        true
      else
        false
      end
    when enable?
       if @@enable.include?(input)
        true
      else
        false
      end
    when configure?
       if @@configure.include?(input)
        true
      else
        false
      end
    end
  end
end
