RUBYMOTION_TEMPLATES_DIR = File.expand_path('~/Library/RubyMotion/template')

Dir[File.dirname(__FILE__) + "/../template/*"].each do |filename|
  name = filename.scan(/[a-z_\-\d]+$/)[0] or fail "Can't find the template folder"

  `rm -rf #{RUBYMOTION_TEMPLATES_DIR}/#{name}`
  `mkdir -p #{RUBYMOTION_TEMPLATES_DIR}/#{name}`
  `cp -r #{filename} #{RUBYMOTION_TEMPLATES_DIR}/#{name}/files`
end

require 'mkmf'
create_makefile('')
