class UnderOs::App

  class << self
    def start(&block)
      @start_block = block
    end

    def setup(ios_app, options)
      @history = UnderOs::History.new

      instance_exec self, &@start_block

      @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      @window.rootViewController = @history._
      @window.makeKeyAndVisible
    end

    def config
      @config ||= UnderOs::Config.new(self)
    end

    def history
      @history
    end

    def stylesheet
      @stylesheet ||= UnderOs::Page::Stylesheet.new.tap do |stylesheet|
        stylesheet.load('under-os.css')
        stylesheet.load('application.css')
      end
    end
  end
end
