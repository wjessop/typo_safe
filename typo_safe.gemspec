# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typo_safe/version'

Gem::Specification.new do |gem|
  gem.name          = "typo_safe"
  gem.version       = TypoSafe::VERSION
  gem.authors       = ["Will Jessop"]
  gem.email         = ["will@willj.net"]
  gem.description   = %q{Make your Ruby code typo safe}
  gem.summary       = %q{You probably don't really want to use this in production. Or ever.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'text'
end
