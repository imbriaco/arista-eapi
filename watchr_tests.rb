watch('spec/(.*).spec')     { |md| system "rspec spec/#{md[1]}.spec"}
watch('lib/arista/(.*).rb')     { |md| system "rspec spec/test_#{md[1]}.spec"}
#watch('lib/(.*).treetop')     { |md| system "ruby lib/parser.rb"}
#watch('lib/(.*).rb')     { |md| system "ruby lib/parser.rb"}
