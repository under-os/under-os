# -*- encoding: utf-8 -*-
require File.expand_path('../lib/under_os', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "under-os"
  gem.version       = UnderOs::VERSION

  gem.authors       = ["Nikolay Nemshilov"]
  gem.email         = ['nemshilov@gmail.com']
  gem.description   = "A web-like thin wrapper over iOS"
  gem.summary       = "A web-like thin wrapper over iOS"
  gem.license       = 'MIT'

  gem.files         = Dir['lib/**/*']

  gem.add_development_dependency 'rake'
end
