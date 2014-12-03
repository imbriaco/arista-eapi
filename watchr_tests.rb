watch('tests/(.*).rb')     { |md| system "rspec tests/#{md[1]}.rb"}
watch('lib/(.*).rb')     { |md| system "rspec spec/test_cli_username.spec"}
#watch('lib/(.*).treetop')     { |md| system "ruby lib/parser.rb"}
#watch('lib/(.*).rb')     { |md| system "ruby lib/parser.rb"}
