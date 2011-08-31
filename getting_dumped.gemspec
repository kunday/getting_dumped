# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "getting_dumped"
  s.version     = '0.0.6'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Arvind Kunday"]
  s.email       = ["hi@kunday.com"]
  s.homepage    = "https://github.com/kunday/getting_dumped"
  s.summary     = %q{the historical RSpec run formatter}
  s.description = %q{the historical RSpec run formatter}

  s.rubyforge_project = "getting_dumped"

  s.files         = `git ls-files`.split("\n")
#  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
#  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('rspec', ["~> 2.0"])
  s.add_dependency('rake')
  s.add_dependency('data_mapper')
  s.add_dependency('dm-sqlite-adapter')
end
