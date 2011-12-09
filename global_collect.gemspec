# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'global_collect/version'

Gem::Specification.new do |s|
  s.name = %q{global_collect}
  s.version = GlobalCollect::VERSION
  s.authors = ["Timon Karnezos", "ThoughtWorks"]
  s.date = '2010-11-02'
  s.summary = 'A Ruby client to the Global Collect API'
  s.description = %q{Gives minimally intrusive access to Global Collect's payment processing API.
Currently implements a very small segment of the full API but is built with
extensibility in mind.
  }

  s.email = 'timon.karnezos@gmail.com'
  s.extra_rdoc_files = ['README.markdown']
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.homepage = 'http://github.com/timonk/global_collect'
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  s.add_dependency 'httparty', '= 0.5.2'
  s.add_dependency 'builder'
  s.add_dependency 'fixed_width'
  s.add_dependency 'fakeweb'
  s.add_dependency 'crack'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'geminabox'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'redcarpet'
end
