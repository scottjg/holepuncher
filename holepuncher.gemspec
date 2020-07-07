# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'holepuncher/version'

Gem::Specification.new do |spec|
  spec.name          = "holepuncher"
  spec.version       = Holepuncher::VERSION
  spec.authors       = ["Scott J. Goldman"]
  spec.email         = ["scottjgo@gmail.com"]

  spec.summary       = %q{Forwards ports on your router}
  spec.homepage      = "https://github.com/scottjg/holepuncher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mupnp", "~> 0.2.0"
  spec.add_runtime_dependency "natpmp", "~> 0.9.1"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
end
