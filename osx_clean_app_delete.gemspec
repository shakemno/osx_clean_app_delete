# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osx_clean_app_delete/version'

Gem::Specification.new do |spec|
  spec.name          = "osx_clean_app_delete"
  spec.version       = OsxCleanAppDelete::VERSION
  spec.authors       = ["shakemno"]
  spec.email         = ["info@shakemno.de"]
  spec.description   = %q{Find and delete any files related to an APP bundle on osx.}
  spec.summary       = %q{Cleanly delete all files for an OSX App}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "thor", "~> 0.18.1"
end
