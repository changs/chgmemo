# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "anemone"
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Kite"]
  s.date = "2011-02-24"
  s.executables = ["anemone"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["bin/anemone", "README.rdoc"]
  s.homepage = "http://anemone.rubyforge.org"
  s.rdoc_options = ["-m", "README.rdoc", "-t", "Anemone"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "anemone"
  s.rubygems_version = "1.8.11"
  s.summary = "Anemone web-spider framework"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<robots>, [">= 0.7.2"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.3.0"])
      s.add_dependency(%q<robots>, [">= 0.7.2"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.3.0"])
    s.add_dependency(%q<robots>, [">= 0.7.2"])
  end
end
