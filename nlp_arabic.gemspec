# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nlp_arabic/version'

Gem::Specification.new do |spec|
  spec.name          = "nlp_arabic"
  spec.version       = NlpArabic::VERSION
  spec.authors       = ["Othmane Laousy"]
  spec.email         = ["othmane.laousy@gmail.com"]

  spec.summary       = %q{Natural Language Processing Tools for Arabic}
  spec.description   = %q{This gem is intended to contain tools for Arabic Natural Language Processing.}
  spec.homepage      = "https://github.com/othmanela/nlp_arabic"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
