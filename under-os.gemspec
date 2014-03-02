# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/gems/under-os-core/lib/under_os'

Gem::Specification.new do |gem|
  gem.name          = "under-os"
  gem.version       = UnderOs::VERSION
  gem.homepage      = "http://under-os.com"

  gem.authors       = ["Nikolay Nemshilov"]
  gem.email         = ['nemshilov@gmail.com']
  gem.description   = "A web-broser like wrapper over iOS"
  gem.summary       = "A web-broser like wrapper over iOS using RubyMotion"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/).reject{|f| f.slice(0,5) == 'gems/'}
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency 'under-os-core', UnderOs::VERSION
  gem.add_dependency 'under-os-http', UnderOs::VERSION
  gem.add_dependency 'under-os-ui',   UnderOs::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'motion-facon'

  gem.extensions = ['ext/extconf.rb']

  gem.post_install_message = <<-END
  = UnderOS #{UnderOs::VERSION} =

  To get started run the following:

  motion create awesomeness --template=uos
  cd awesomeness
  rake

  END

end
