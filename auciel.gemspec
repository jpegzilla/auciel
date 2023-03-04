# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'auciel'
  s.version     = '0.1.0'
  s.date        = '2023-03-04'
  s.summary     = "this is a wrapper for black desert's marketplace api."
  s.description = 'an api used to get data from the black desert online central market.'
  s.authors     = ['jpegzilla']
  s.email       = 'eris@jpegzilla.com'
  s.files       = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md', 'nodemon.json']
  s.homepage    = 'https://github.com/jpegzilla/auciel'
  s.license     = 'MIT'
  s.add_runtime_dependency 'tsurezure', '>= 0.0.36'
end
