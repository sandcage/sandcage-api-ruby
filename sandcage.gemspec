# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sandcage/version'

Gem::Specification.new do |spec|
  spec.name          = "sandcage"
  spec.version       = Sandcage::VERSION
  spec.authors       = ["Antti Nykänen", "SandCage"]
  spec.email         = ["ajjn@iki.fi", "contact@sandcage.com"]
  spec.licenses      = ["Apache-2.0"]
  spec.summary       = %q{Access SandCage's API.}
  spec.description   = %q{Ruby library to access SandCage's API services.}
  spec.homepage      = "https://github.com/sandcage/sandcage-api-ruby"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|examples)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "httparty", "~> 0.13.7"
  spec.add_runtime_dependency "certifi", "~> 2016.9"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
