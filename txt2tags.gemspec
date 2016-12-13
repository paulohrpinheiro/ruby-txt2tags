Gem::Specification.new do |s|
  s.name        = 'txt2tags'
  s.version     = '0.0.1'
  s.summary     = 'Ruby txt2tags implementation.'
  s.description = 'Converts a text file with minimal markup to various formats'
  s.authors     = ['Paulo Henrique Rodrigues Pinheiro']
  s.email       = 'paulohrpinheiro@gmail.com'
  s.homepage    = 'https://github.com/paulohrpinheiro/ruby-txt2tags'
  s.files       = ['lib/txt2tags.rb']
  s.license     = 'MIT'

  s.executables << 'txt2tags-rb'

  s.add_runtime_dependency "htmlentities", ["~> 4.3"]
  s.add_dev
end
