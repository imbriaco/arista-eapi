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

  it 'MockCli#username success with number in name' do
    user = "test3"
    password = "password"
    role = "network-admin"

    cli = MockCli.new()
    cli.run(['enable'])
    cli.run(['configure'])
    cmd = "username #{user} role #{role} secret 0 #{password}"
    response = cli.run([cmd])
    expect(response).to eq ''
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
    expect(response).to eq ''
  end

  it 'MockCli#username sshkey successful' do
    user = "test"
    password = "password"
    sshkey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2zGA/4TgBKdcwQQewyIvlXUQ62yV0kxxUFSV+sGzDxzpE6zK+pJj2DZlrKt6i3om3eMFSOd2MV45C/YFvaxe73ufipRQ7hvzlWMWB7MgCHygWW3qJGX/3qix/AvQU4mr4iWIG/Uin169Cdk93Siv7IRXf5tGE6nw6O1nTNONT5M188AgWRH48P9kQ4wotSlPn5Msy7F/ZTf6Vnqq9yj/3rQzob2pm+DSW9xsXIrz/hjadSjhV7rn0Yh3appIjOxigfFmFjpNHyzb2KUpRq2QT606vAMlk88QcoK7kyTsJ/oN7IG9Ekh3IIURXTeFs/EW+AmfrtFeV3KoMXf6jFdDAw== bnguyen@zero"

    cli = MockCli.new()
    cli.run(['enable'])
    cli.run(['configure'])
    cmd = "username #{user} sshkey #{sshkey}"
    response = cli.run([cmd])
    expect(response).to eq ''
  end

  it 'MockCli#username sshkey invalid key' do
    user = "test"
    password = "password"
    sshkey = "ssh-rsa IwAAAQEA2zGA/4TgBKdcwQQewyIvlXUQ62yV0kxxUFSV+sGzDxzpE6zK+pJj2DZlrKt6i3om3eMFSOd2MV45C/YFvaxe73ufipRQ7hvzlWMWB7MgCHygWW3qJGX/3qix/AvQU4mr4iWIG/Uin169Cdk93Siv7IRXf5tGE6nw6O1nTNONT5M188AgWRH48P9kQ4wotSlPn5Msy7F/ZTf6Vnqq9yj/3rQzob2pm+DSW9xsXIrz/hjadSjhV7rn0Yh3appIjOxigfFmFjpNHyzb2KUpRq2QT606vAMlk88QcoK7kyTsJ/oN7IG9Ekh3IIURXTeFs/EW+AmfrtFeV3KoMXf6jFdDAw== bnguyen@zero"

    cli = MockCli.new()
    cli.run(['enable'])
    cli.run(['configure'])
    cmd = "username #{user} sshkey #{sshkey}"
    response = cli.run([cmd])
    expect(response).to eq 'Unrecognized ssh key'
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
    expect(response).to eq ''
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
    expect(response).to eq ''
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
