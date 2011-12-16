# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "googlecharts"
  s.version = "1.6.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Aimonetti", "Andrey Deryabin"]
  s.date = "2011-05-20"
  s.description = "Generate charts using Google API & Ruby"
  s.email = "mattaimonetti@gmail.com deriabin@gmail.com"
  s.homepage = "http://googlecharts.rubyforge.org/"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Generate charts using Google API & Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
