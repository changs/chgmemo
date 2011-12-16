# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "pagination"
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cyril David"]
  s.date = "2010-06-09"
  s.description = "Trying to make the pagination world a better place"
  s.email = "cyx.ucron@gmail.com"
  s.executables = ["pagination"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["bin/pagination", "LICENSE", "README.md"]
  s.homepage = "http://github.com/sinefunc/pagination"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "A simplistic pagination library"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<contest>, [">= 0"])
      s.add_development_dependency(%q<haml>, [">= 0"])
    else
      s.add_dependency(%q<contest>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
    end
  else
    s.add_dependency(%q<contest>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
  end
end
