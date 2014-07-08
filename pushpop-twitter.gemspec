# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'pushpop-twitter/version'

Gem::Specification.new do |s|

  s.name        = "pushpop-twitter"
  s.version     = Pushpop::Twitter::VERSION
  s.authors     = ["Josh Dzielak"]
  s.email       = "josh@keen.io"
  s.homepage    = "https://github.com/pushpop-project/pushpop-twitter"
  s.summary     = "A set of Pushpop capabilities for the Twitter API"

  s.add_dependency "pushpop"
  s.add_dependency "twitter"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

