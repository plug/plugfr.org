# -*- encoding: utf-8 -*-
# stub: classifier 1.3.4 ruby lib

Gem::Specification.new do |s|
  s.name = "classifier"
  s.version = "1.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Lucas Carlson"]
  s.autorequire = "classifier"
  s.date = "2013-12-31"
  s.description = "   A general classifier module to allow Bayesian and other types of classifications.\n"
  s.email = "lucas@rufy.com"
  s.homepage = "http://classifier.rufy.com/"
  s.requirements = ["A porter-stemmer module to split word stems."]
  s.rubygems_version = "2.2.2"
  s.summary = "A general classifier module to allow Bayesian and other types of classifications."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fast-stemmer>, [">= 1.0.0"])
    else
      s.add_dependency(%q<fast-stemmer>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<fast-stemmer>, [">= 1.0.0"])
  end
end
