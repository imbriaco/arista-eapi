# Arista::EAPI

This gem is designed to make it easy to interact with the Command API that
was introduced by Arista Networks in EOS version 4.12.0.

This is very much an early work in progress. Patches welcome.

## Installation

Add this line to your application's Gemfile:

    gem 'arista-eapi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arista-eapi

## Usage

The primary method for interacting with the gem is via the ```Arista::EAPI::Switch#run``` method.

```
switch = Arista::EAPI::Switch.new(hostname, user, password)
switch.version
#=>
{:model_name=>"DCS-7048T-A-R", :internal_version=>"4.12.0-1244071.EOS4120", :system_mac_address=>"00:1c:73:16:c2:c8", :serial_number=>"redacted", :mem_total=>4009152, :bootup_timestamp=>1368735672.690161, :mem_free=>1848284, :version=>"4.12.0", :architecture=>"i386", :internal_build_id=>"c25ec8ea-cb8f-40a8-af0b-d11eaa94d57c", :hardware_revision=>"01.04"}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
