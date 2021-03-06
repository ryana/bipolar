# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bipolar}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Angilly"]
  s.date = %q{2010-06-25}
  s.description = %q{}
  s.email = %q{ryan@angilly.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "MIT-LICENSE",
     "README",
     "Rakefile",
     "VERSION",
     "lib/bipolar.rb",
     "test/test_helper.rb",
     "test/unit/test_bipolar.rb",
     "test/unit/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/ryana/bipolar}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{MongoMapper plugin for first-class documents that can also be embedded}
  s.test_files = [
    "test/test_helper.rb",
     "test/unit/test_bipolar.rb",
     "test/unit/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, ["= 2.11.0"])
      s.add_development_dependency(%q<mocha>, ["= 0.9.8"])
      s.add_development_dependency(%q<mongo_mapper>, ["= 0.8.2"])
      s.add_development_dependency(%q<ruby-debug>, ["= 0.10.3"])
    else
      s.add_dependency(%q<shoulda>, ["= 2.11.0"])
      s.add_dependency(%q<mocha>, ["= 0.9.8"])
      s.add_dependency(%q<mongo_mapper>, ["= 0.8.2"])
      s.add_dependency(%q<ruby-debug>, ["= 0.10.3"])
    end
  else
    s.add_dependency(%q<shoulda>, ["= 2.11.0"])
    s.add_dependency(%q<mocha>, ["= 0.9.8"])
    s.add_dependency(%q<mongo_mapper>, ["= 0.8.2"])
    s.add_dependency(%q<ruby-debug>, ["= 0.10.3"])
  end
end

