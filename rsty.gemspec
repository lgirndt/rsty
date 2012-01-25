Gem::Specification.new do |s|
  s.name = 'rsty'
  s.version = '0.1.0'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '~> 1.9.2'
  s.authors = ['Lars Girndt']
  s.email = ['lars.girndt@brands4friends.com']
  s.summary = 'SOME SUMMARY'
  s.description = 'SOME DESCRIPTION'
  
  s.required_rubygems_version = ">= 1.3.6"
  
  s.add_dependency 'json', '~> 1.6.5'
  s.add_dependency 'rest-client', '~> 1.6.7'
  s.add_dependency 'colorize', '~> 0.5.8'
    
  s.files = Dir['lib/**/*.rb'] +  Dir['bin/*'] + Dir['data/**/*']
  s.executables = ['rsty']  
end