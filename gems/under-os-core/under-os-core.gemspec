# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/under_os"

Gem::Specification.new do |gem|
  gem.name          = "under-os-core"
  gem.version       = UnderOs::VERSION
  gem.homepage      = "http://under-os.com"

  gem.authors       = ["Nikolay Nemshilov"]
  gem.email         = ['nemshilov@gmail.com']
  gem.description   = "The core part of the UnderOs project"
  gem.summary       = "The core part of the UnderOs project. Summaries FTW"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_development_dependency 'rake'
end
