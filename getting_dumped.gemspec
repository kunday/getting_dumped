# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'getting_dumped'
  s.version     = '0.0.4.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Arvind Kunday']
  s.email       = ['arvind@kunday.com']
  s.homepage    = 'https://github.com/kunday/getting_dumped'
  s.summary     = 'the historical RSpec run formatter'
  s.description = 'the historical RSpec run formatter'

  s.rubyforge_project = 'getting_dumped'

  s.files         = `git ls-files lib`.split("\n")
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency('rake')
  s.add_dependency('rspec')
  s.add_dependency('sequel')
  s.add_dependency('sinatra')
  s.add_dependency('sinatra-snap')
  s.add_dependency('sqlite3')
  s.add_development_dependency('byebug')
  s.add_development_dependency('rubocop')
end
