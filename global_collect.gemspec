Gem::Specification.new do |s|
  s.name = %q{global_collect}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Timon Karnezos"]
  s.date = '2010-11-02'
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
  s.rubygems_version = '1.3.6'
  s.summary = 'A Ruby client to the Global Collect API'

  current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
  s.specification_version = 3

  s.add_dependency 'httparty', '= 0.5.2'
  s.add_dependency 'builder'
  s.add_dependency 'fixed_width'
  s.add_dependency 'fakeweb'
  s.add_dependency 'crack'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
end
