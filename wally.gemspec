# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wally/version"

Gem::Specification.new do |s|
  s.name        = "wally"
  s.version     = Wally::VERSION
  s.authors     = ["Andrew Vos"]
  s.email       = ["andrew.vos@gmail.com"]
  s.homepage    = "https://github.com/BBC-News/wally"
  s.summary     = %q{Cucumber feature viewer and navigator}
  s.description = %q{Cucumber feature viewer and navigator}

  s.files         = `git ls-files`.split("\n")
  s.files << "README.md"
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "sinatra"
  s.add_runtime_dependency "haml"
  s.add_runtime_dependency "rdiscount"
  s.add_runtime_dependency "gherkin"
  s.add_runtime_dependency "komainu"
  s.add_runtime_dependency "mongo_mapper"
  s.add_runtime_dependency "bson_ext"

  s.add_development_dependency "cucumber"
  s.add_development_dependency "capybara"
  s.add_development_dependency "rspec"
  s.add_development_dependency "fakefs"
  s.add_development_dependency "launchy"
  s.add_development_dependency "pry"
end
