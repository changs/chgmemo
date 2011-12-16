# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "r18n-core"
  s.version = "0.4.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrey \"A.I.\" Sitnik"]
  s.date = "2011-10-02"
  s.description = "    R18n is a i18n tool to translate your Ruby application.\n    It has nice Ruby-style syntax, filters, flexible locales, custom loaders,\n    translation support for any classes, time and number localization, several\n    user language support, agnostic core package with out-of-box support for\n    Rails, Sinatra, Merb and desktop applications.\n"
  s.email = "andrey@sitnik.ru"
  s.extra_rdoc_files = ["README.rdoc", "LICENSE", "ChangeLog"]
  s.files = ["README.rdoc", "LICENSE", "ChangeLog"]
  s.homepage = "http://r18n.rubyforge.org/"
  s.require_paths = ["lib"]
  s.rubyforge_project = "r18n-core"
  s.rubygems_version = "1.8.11"
  s.summary = "I18n tool to translate your Ruby application."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 1.0.10"])
      s.add_development_dependency(%q<hanna>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["!= 0.9.0", ">= 0"])
      s.add_development_dependency(%q<rspec-core>, [">= 0"])
      s.add_development_dependency(%q<rspec-expectations>, [">= 0"])
      s.add_development_dependency(%q<rspec-mocks>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<maruku>, [">= 0"])
      s.add_development_dependency(%q<RedCloth>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0.10"])
      s.add_dependency(%q<hanna>, [">= 0"])
      s.add_dependency(%q<rake>, ["!= 0.9.0", ">= 0"])
      s.add_dependency(%q<rspec-core>, [">= 0"])
      s.add_dependency(%q<rspec-expectations>, [">= 0"])
      s.add_dependency(%q<rspec-mocks>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<maruku>, [">= 0"])
      s.add_dependency(%q<RedCloth>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0.10"])
    s.add_dependency(%q<hanna>, [">= 0"])
    s.add_dependency(%q<rake>, ["!= 0.9.0", ">= 0"])
    s.add_dependency(%q<rspec-core>, [">= 0"])
    s.add_dependency(%q<rspec-expectations>, [">= 0"])
    s.add_dependency(%q<rspec-mocks>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<maruku>, [">= 0"])
    s.add_dependency(%q<RedCloth>, [">= 0"])
  end
end
