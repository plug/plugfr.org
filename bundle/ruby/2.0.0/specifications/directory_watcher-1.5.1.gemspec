# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "directory_watcher"
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Pease", "Jeremy Hinegardner"]
  s.date = "2013-03-20"
  s.description = "The directory watcher operates by scanning a directory at some interval and\ngenerating a list of files based on a user supplied glob pattern. As the file\nlist changes from one interval to the next, events are generated and\ndispatched to registered observers. Three types of events are supported --\nadded, modified, and removed."
  s.email = "tim.pease@gmail.com"
  s.extra_rdoc_files = ["History.txt", "README.txt"]
  s.files = ["History.txt", "README.txt"]
  s.homepage = "http://rubygems.org/gems/directory_watcher"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "directory_watcher"
  s.rubygems_version = "2.0.3"
  s.summary = "A class for watching files within a directory and generating events when those files change"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rev>, [">= 0.3.2"])
      s.add_development_dependency(%q<eventmachine>, [">= 1.0.3"])
      s.add_development_dependency(%q<cool.io>, [">= 1.1.0"])
      s.add_development_dependency(%q<bones-git>, ["~> 1.2.4"])
      s.add_development_dependency(%q<bones-rspec>, ["~> 2.0.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.7.0"])
      s.add_development_dependency(%q<logging>, ["~> 1.6.1"])
      s.add_development_dependency(%q<bones>, [">= 3.8.0"])
    else
      s.add_dependency(%q<rev>, [">= 0.3.2"])
      s.add_dependency(%q<eventmachine>, [">= 1.0.3"])
      s.add_dependency(%q<cool.io>, [">= 1.1.0"])
      s.add_dependency(%q<bones-git>, ["~> 1.2.4"])
      s.add_dependency(%q<bones-rspec>, ["~> 2.0.1"])
      s.add_dependency(%q<rspec>, ["~> 2.7.0"])
      s.add_dependency(%q<logging>, ["~> 1.6.1"])
      s.add_dependency(%q<bones>, [">= 3.8.0"])
    end
  else
    s.add_dependency(%q<rev>, [">= 0.3.2"])
    s.add_dependency(%q<eventmachine>, [">= 1.0.3"])
    s.add_dependency(%q<cool.io>, [">= 1.1.0"])
    s.add_dependency(%q<bones-git>, ["~> 1.2.4"])
    s.add_dependency(%q<bones-rspec>, ["~> 2.0.1"])
    s.add_dependency(%q<rspec>, ["~> 2.7.0"])
    s.add_dependency(%q<logging>, ["~> 1.6.1"])
    s.add_dependency(%q<bones>, [">= 3.8.0"])
  end
end
