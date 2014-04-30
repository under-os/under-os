require "under_os"

UnderOs.instance_eval do
  #
  # Generic ecosystem extension hook, for plugins and such
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
            Dir.glob(File.dirname(__file__) + '/**/*.rb').sort.each do |file|
              position = app.files.index {|i| i.slice(0, 2) == "./" }
              app.files.insert(position, file) if file != __file__
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

UnderOs.extend __FILE__
