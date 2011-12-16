require '../r18n-core/lib/r18n-core/version'

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'r18n-core'
  s.version = R18n::VERSION.dup
  s.date = Time.now.strftime('%Y-%m-%d')
  s.summary = 'I18n tool to translate your Ruby application.'
  s.description = <<-EOF
    R18n is a i18n tool to translate your Ruby application.
    It has nice Ruby-style syntax, filters, flexible locales, custom loaders,
    translation support for any classes, time and number localization, several
    user language support, agnostic core package with out-of-box support for
    Rails, Sinatra, Merb and desktop applications.
  EOF

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.rdoc', 'LICENSE', 'ChangeLog']
  s.require_path = 'lib'

  s.author = 'Andrey "A.I." Sitnik'
  s.email = 'andrey@sitnik.ru'
  s.homepage = 'http://r18n.rubyforge.org/'
  s.rubyforge_project = 'r18n-core'

  s.add_development_dependency "bundler", [">= 1.0.10"]
  s.add_development_dependency "hanna", [">= 0"]
  s.add_development_dependency "rake", [">= 0", "!= 0.9.0"]
  s.add_development_dependency "rspec-core", [">= 0"]
  s.add_development_dependency "rspec-expectations", [">= 0"]
  s.add_development_dependency "rspec-mocks", [">= 0"]
  s.add_development_dependency "rcov", [">= 0"]
  s.add_development_dependency "maruku", [">= 0"]
  s.add_development_dependency "RedCloth", [">= 0"]
end
