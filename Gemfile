source 'https://rubygems.org'

# Specify your gem's dependencies in arista-eapi.gemspec
gemspec

gem 'sshkey'

group 'test' do
  gem 'sinatra'
  gem 'rspec'
  gem 'webmock'
end

group 'development' do
  gem 'rake'
  gem 'guard'
  gem 'guard-rspec'
  gem 'foodcritic', git: 'https://github.com/mlafeldt/foodcritic.git', branch: 'improve-rake-task'
  gem 'rubocop'
end
