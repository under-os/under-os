class UnderOs::App

  class << self
    def start(&block)
      @start_block = block
    end

    def setup(ios_app, options)
      @navigation = UnderOs::Navigation.new

      instance_exec self, &@start_block

      @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      @window.rootViewController = @navigation._
      @window.makeKeyAndVisible
    end

    def config
      @config ||= UnderOs::Config.new(self)
    end

    def navigation
      @navigation
    end

    def stylesheet
      @stylesheet ||= begin
        stylesheet = UnderOs::Page::Stylesheet.new
        stylesheet.load('under-os.css')
        stylesheet.load('application.css')
        stylesheet
      end
    end
  end
end
