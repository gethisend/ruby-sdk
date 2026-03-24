Gem::Specification.new do |s|
  s.name        = 'hisend'
  s.version     = '1.0.0'
  s.summary     = 'Official Ruby SDK for Hisend'
  s.description = 'The official Hisend Ruby client for interacting with the Hisend API.'
  s.authors     = ['Hisend']
  s.email       = 'support@hisend.app'
  s.homepage    = 'https://hisend.app'
  s.license     = 'MIT'

  s.files       = Dir['lib/**/*.rb', 'LICENSE', 'README.md']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.6.0'

  s.add_development_dependency 'minitest', '~> 5.0'
end
