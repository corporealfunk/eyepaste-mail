# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "eyepaste-mail/version"

Gem::Specification.new do |s|
  s.name        = "eyepaste-mail"
  s.version     = Eyepaste::Mail::VERSION
  s.authors     = ["Jon Moniaci"]
  s.email       = ["jonmoniaci [at] gmail.com"]
  s.homepage    = "https://github.com/corporealfunk/eyepaste-mail"
  s.summary     = %q{Works with Mail gem to munge email 'To:' addresses into @eyepaste.com addresses}
  s.description = %q{Implements an email interceptor which, when registered with the Mail gem, munges all "To:" email address to @eyepaste.com addresses. Especially helpful in dev or staging environments when you don't want emails delivered to actual addresses, but you may want to verify actual delivery.}

  s.rubyforge_project = "eyepaste-mail"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "mail"
end
