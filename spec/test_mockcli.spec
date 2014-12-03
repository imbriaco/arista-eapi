require 'arista/mockcli'
require 'json'

describe 'MockCli' do
  it 'MockCli#initalize' do
    cli = MockCli.new()
    expect(cli.default?).to be true
  end

  it 'MockCli#enable' do
    cli = MockCli.new()
    cli.run(['enable'])
    expect(cli.enable?).to be true
  end

  it 'MockCli#show version' do
    cli = MockCli.new()
    cli.run(['enable'])
    expect(cli.enable?).to be true
    response = cli.run(['show version'])
    expect(response).to eq 'version'
  end

  it 'MockCli#configure error' do
    cli = MockCli.new()
    cli.run(['configure'])
    expect(cli.configure?).to be false
  end

  it 'MockCli#configure success' do
    cli = MockCli.new()
    cli.run(['enable'])
    cli.run(['configure'])
    expect(cli.configure?).to be true
  end

  it 'MockCli#configure invalid' do
    cli = MockCli.new()
    cli.run(['enable'])
    response = cli.run(['configuremispelled'])
    expect(response).to eq 'Invalid input'
  end

  it 'MockCli#username error' do
    cli = MockCli.new()
    cli.run(['enable'])
    cli.run(['configure'])
    response = cli.run(['username'])
    expect(response).to eq 'Incomplete command'
  end

  it 'MockCli#username success' do
    user = "test"
    password = "password"
    role = "network-admin"

    cli = MockCli.new()
    cli.run(['enable'])
    cli.run(['configure'])
    cmd = "username #{user} role #{role} secret 0 #{password}"
    response = cli.run([cmd])
    expect(response).to eq '{}'
  end

  it 'MockCli#show running-config' do
    user = "test"
    password = "password"
    role = "network-admin"

    cli = MockCli.new()
    cli.run(['enable'])
    cli.run(['configure'])
    cmd = "username #{user} role #{role} secret 0 #{password}"
    response = cli.run([cmd])
    response = cli.run(['show running-config'])
    expect(response).to eq [cmd]
  end

end
