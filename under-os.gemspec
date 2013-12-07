# -*- encoding: utf-8 -*-
require File.expand_path('../lib/under_os', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "under-os"
  gem.version       = UnderOs::VERSION
  gem.homepage      = "http://under-os.com"

  gem.authors       = ["Nikolay Nemshilov"]
  gem.email         = ['nemshilov@gmail.com']
  gem.description   = "A web-broser like wrapper over iOS"
  gem.summary       = "A web-broser like wrapper over iOS using RubyMotion"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_development_dependency 'rake'

  gem.post_install_message = %Q{
  If you want to use the UnderOS template with RubyMotion, please run the following:

    mkdir -p ~/Library/RubyMotion/template/uos
    git clone https://github.com/under-os/under-os-template.git ~/Library/RubyMotion/template/uos


  Then just run the following to generate your first project:

    motion create awesomness --template=uos
  }
end
