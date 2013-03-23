# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jekyll"
  s.version = "0.12.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Preston-Werner"]
  s.date = "2013-02-19"
  s.description = "Jekyll is a simple, blog aware, static site generator."
  s.email = "tom@mojombo.com"
  s.executables = ["jekyll"]
  s.extra_rdoc_files = ["README.textile", "LICENSE"]
  s.files = ["bin/jekyll", "README.textile", "LICENSE"]
  s.homepage = "http://github.com/mojombo/jekyll"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "jekyll"
  s.rubygems_version = "2.0.3"
  s.summary = "A simple, blog aware, static site generator."

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<liquid>, ["~> 2.3"])
      s.add_runtime_dependency(%q<classifier>, ["~> 1.3"])
      s.add_runtime_dependency(%q<directory_watcher>, ["~> 1.1"])
      s.add_runtime_dependency(%q<maruku>, ["~> 0.5"])
      s.add_runtime_dependency(%q<kramdown>, ["~> 0.14"])
      s.add_runtime_dependency(%q<pygments.rb>, ["~> 0.3.2"])
      s.add_development_dependency(%q<rake>, ["~> 10.0.3"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_development_dependency(%q<redgreen>, ["~> 1.2"])
      s.add_development_dependency(%q<shoulda>, ["~> 3.3.2"])
      s.add_development_dependency(%q<rr>, ["~> 1.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 1.2.1"])
      s.add_development_dependency(%q<RedCloth>, ["~> 4.2"])
      s.add_development_dependency(%q<rdiscount>, ["~> 1.6"])
      s.add_development_dependency(%q<redcarpet>, ["~> 2.2.2"])
    else
      s.add_dependency(%q<liquid>, ["~> 2.3"])
      s.add_dependency(%q<classifier>, ["~> 1.3"])
      s.add_dependency(%q<directory_watcher>, ["~> 1.1"])
      s.add_dependency(%q<maruku>, ["~> 0.5"])
      s.add_dependency(%q<kramdown>, ["~> 0.14"])
      s.add_dependency(%q<pygments.rb>, ["~> 0.3.2"])
      s.add_dependency(%q<rake>, ["~> 10.0.3"])
      s.add_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_dependency(%q<redgreen>, ["~> 1.2"])
      s.add_dependency(%q<shoulda>, ["~> 3.3.2"])
      s.add_dependency(%q<rr>, ["~> 1.0"])
      s.add_dependency(%q<cucumber>, ["~> 1.2.1"])
      s.add_dependency(%q<RedCloth>, ["~> 4.2"])
      s.add_dependency(%q<rdiscount>, ["~> 1.6"])
      s.add_dependency(%q<redcarpet>, ["~> 2.2.2"])
    end
  else
    s.add_dependency(%q<liquid>, ["~> 2.3"])
    s.add_dependency(%q<classifier>, ["~> 1.3"])
    s.add_dependency(%q<directory_watcher>, ["~> 1.1"])
    s.add_dependency(%q<maruku>, ["~> 0.5"])
    s.add_dependency(%q<kramdown>, ["~> 0.14"])
    s.add_dependency(%q<pygments.rb>, ["~> 0.3.2"])
    s.add_dependency(%q<rake>, ["~> 10.0.3"])
    s.add_dependency(%q<rdoc>, ["~> 3.11"])
    s.add_dependency(%q<redgreen>, ["~> 1.2"])
    s.add_dependency(%q<shoulda>, ["~> 3.3.2"])
    s.add_dependency(%q<rr>, ["~> 1.0"])
    s.add_dependency(%q<cucumber>, ["~> 1.2.1"])
    s.add_dependency(%q<RedCloth>, ["~> 4.2"])
    s.add_dependency(%q<rdiscount>, ["~> 1.6"])
    s.add_dependency(%q<redcarpet>, ["~> 2.2.2"])
  end
end
