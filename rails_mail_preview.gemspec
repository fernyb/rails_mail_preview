# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails_mail_preview/version"

Gem::Specification.new do |s|
  s.name        = "rails_mail_preview"
  s.version     = RailsMailPreview::VERSION
  s.authors     = ["Fernando Barajas"]
  s.email       = ["fernyb@fernyb.net"]
  s.homepage    = ""
  s.summary     = %q{A Rails plugin gem to intercept emails in development and preview them in RMailPreview.}
  s.description = %q{A Rails plugin gem to intercept emails in development and preview them in RMailPreview to get an idea of what it will look like when it's sent in production.}

  s.rubyforge_project = "rails_mail_preview"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('FBDistributedNotification', '0.0.1')
  s.add_dependency('rails', '>= 3.0.0')
end
