# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "specialprocedures.github.io"
  spec.version       = "0.1"
  spec.authors       = ["Ian Goodrich"]
  spec.email         = ["feedback@startbootstrap.com"]

  spec.summary       = "A simple blog theme based on theme by Start Bootstrap."
  spec.homepage      = "https://github.com/StartBootstrap/startbootstrap-clean-blog-jekyll"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|_layouts|_includes|_sass|LICENSE|README)}i) }

  spec.add_runtime_dependency "jekyll", ">= 3.8.5"

  spec.add_development_dependency "bundler", "~> 2.0.1"
  spec.add_development_dependency "rake", "~> 12.0"
end
