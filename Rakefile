# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require

require 'under-os'

Motion::Project::App.setup do |app|
  app.name       = 'under-os'
  app.identifier = 'com.under-os'
  app.specs_dir  = './spec/lib'
  app.version    = UnderOs::VERSION

  app.codesign_certificate = ENV['RUBYMOTION_CERTIFICATE']
  app.provisioning_profile = ENV['RUBYMOTION_PROFILE']
end
