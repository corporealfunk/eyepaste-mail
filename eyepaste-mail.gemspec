# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "eyepaste-mail/version"

Gem::Specification.new do |s|
  s.name        = "eyepaste-mail"
  s.version     = Eyepaste::Mail::VERSION
  s.authors     = ["Jon Moniaci"]
  s.email       = ["jonmoniaci [at] gmail.com"]
  s.homepage    = "http://www.github.com/corporealfunk/eyepaste-mail"
  s.summary     = %q{Works with Mail gem to send emails to eyepaste}
  s.description = %q{Impelments an email interceptor to work with the Mail gem to faciliate sending emails to eyepaste in dev or staging environments}

  s.rubyforge_project = "eyepaste-mail"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "mail"
end
