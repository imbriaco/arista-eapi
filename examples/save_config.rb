#!/usr/bin/env ruby

require 'arista/eapi'

user = ENV['EAPI_USER']
password = ENV['EAPI_PASSWORD']
all = %w(switch1.example.com switch2.example.com)

all.each do |hostname|
  print "Saving configuration for #{hostname} ... "

  outdir = File.join(File.dirname(__FILE__), hostname)
  File.directory?(outdir) || FileUtils.mkdir(outdir)

  sw = Arista::EAPI::Switch.new(hostname, user, password)
  results = sw.run('enable', 'show running-config')

  File.open(File.join(outdir, 'startup-config'), 'w') do |f|
    results.each do |res|
      next if res[:output] == ''
      f.puts res[:output]
    end
  end

  puts "done."
end

