lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "petitest/version"

Gem::Specification.new do |spec|
  spec.name = "petitest"
  spec.version = Petitest::VERSION
  spec.authors = ["Ryo Nakamura"]
  spec.email = ["r7kamura@gmail.com"]
  spec.summary = "A minimal solid testing framework for Ruby."
  spec.homepage = "https://github.com/petitest/petitest"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.1.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "petitest-power_assert"
  spec.add_development_dependency "rake", "~> 10.0"
end
