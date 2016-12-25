Gem::Specification.new do |s|
  s.name        = 'txt2tags'
  s.version     = '0.1.0'
  s.summary     = 'Ruby txt2tags implementation.'
  s.description = 'Converts a text file with minimal markup to various formats'
  s.authors     = ['Paulo Henrique Rodrigues Pinheiro']
  s.email       = 'paulohrpinheiro@gmail.com'
  s.homepage    = 'https://github.com/paulohrpinheiro/ruby-txt2tags'
  s.files       = Dir['lib/**/*.rb']
  s.license     = 'MIT'

  s.executables << 'txt2tags-rb'

  s.required_ruby_version = '>= 2.0'

  s.add_runtime_dependency 'htmlentities', ['~> 4.3']
  s.add_development_dependency 'rake', ['~> 0']
end
