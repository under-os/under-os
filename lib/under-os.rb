# just a gem hook

Motion::Project::App.instance_eval do
  alias :setup_before_under_os :setup

  def setup(*args, &block)
    config.setup_blocks << proc do |app|
      Dir.glob(File.dirname(__FILE__) + '/**/*.rb').reverse.each do |file|
        app.files.insert(0, file) if file != __FILE__
      end
    end

    setup_before_under_os *args, &block
  end
end
