require 'sinatra/base'

# local classes
require 'arista/mockcli'

class MockEAPI < Sinatra::Base

  # Setting up JSON as the default content_type
  before do
    @req_data = JSON.parse(request.body.read.to_s)
  end

  def return_error(input)
    error = {

      'jsonrpc' => '2.0',
      'error' => {
        'data' => [],
      },
      'id' => 'CapiExplorer-123'
    }
    input.each do |e|
      error['error']['data']['errors'] << e
    end
    json_response(error)
    puts "error: #{response_error}"
  end

  def return_successful(input)
    success = {
      'jsonrpc' => '2.0',
      'result' => [],
      'id' => 'CapiExplorer-123'
    }
    input.each do |e|
      success['result'] << e
    end
    puts "successful: #{success}"
    json_response(success)
  end

  def json_response(msg)
    content_type :json
    puts "response: #{msg}"
    return msg.to_json
  end

  post '/command-api' do
    puts "DEBUG: Input JSON: #{@req_data}"

    input = @req_data['params']
    result = []
    error=false
    successful=false

    if correct_version?(input['version'])
      if input.has_key?('cmds')
        a = MockCli.new()
        input['cmds'].each do |i|
          puts "CMDS: #{i}"
          response = a.run([i])
          puts "Response: #{response}"

          if response == 'Invalid command'
            result << "Invalid command"
            error = true
          elsif response == 'Invalid input'
            result << "Invalid input"
            error = true
          elsif  response == ''
            result << '{}'
            successful = true
          else
            result << response
            successful = true
          end
          puts "i: #{i}"
        end
      end
    end

    puts "error: #{error}"
    puts "successful: #{successful}"
    puts "result: #{result}"

    if error
      return return_error(result)
    else
      return return_successful(result)
    end
  end

  def correct_version?(input)
    if input == 1
      return true
    else
      return false
    end
  end

#'{}{:header=>["! device: localhost (vEOS, EOS-4.14.2F)\n!\n"], :comments=>[], :cmds=>{:"ip route 0.0.0.0_0 192.168.56.1"=>nil}}'
  get '/command-api' do
    #json_response 200, 'contributors.json'
    #status
    "202"
  end

  get '/command-api/:cmd' do
    content_type :json
    { :key1 => 'show running' }.to_json
  end

  get '/command-api/abc' do
    content_type :json
    { :key1 => 'abc' }.to_json
  end

  private

  def status
    content_type :json
    status "202"
  end
end


#switch = Server( "https://username:passw0rd@myswitch/command-api" )
#   response = switch.runCmds( 1, ["show version"] )
#   print "The switch's system MAC addess is", response[0]["systemMacAddress"]
