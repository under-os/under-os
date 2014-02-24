module UnderOs
  VERSION='1.3.0'

  #
  # Generic ecosystem extension hook, for plugins and such
  #
  #     require('under-os')
  #
  #     UnderOs.extend __FILE__ do |app|
  #       app.extra_things..
  #     end
  #
  def self.extend(__file__, &block)
    UnderOs.setup_callbacks[__file__] = block
    UnderOs.setup_callbacks.size == 1 && Motion::Project::App.instance_eval do
      alias :setup_before_under_os :setup
      def setup(*args, &block)
        config.setup_blocks << proc do |app|
          UnderOs.setup_callbacks.each do |__file__, block|
            Dir.glob(File.dirname(__file__) + '/**/*.rb').reverse.each do |file|
              app.files.insert(0, file) if file != __file__
            end

            module_assets_folder = File.dirname(__file__) + "/assets"
            app.resources_dirs << module_assets_folder if File.exists?(module_assets_folder)

            block.call(app) if block
          end
        end

        setup_before_under_os *args, &block
      end
    end
  end

  def self.setup_callbacks
    @callbacks ||= {}
  end
end

UOS = UnderOS = UnderOs
