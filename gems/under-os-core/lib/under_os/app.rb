class UnderOs::App

  class << self

    def start(&block)
      @start_block = block
    end

    def setup(ios_app, options)
      instance_exec self, &@start_block

      @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      @window.rootViewController = root_controller
      @window.makeKeyAndVisible
    end

    def config
      @config ||= UnderOs::Config.new(self)
    end

  protected

    def root_controller
      # just a fallback, supposed to be replaced with the real thing in a submodule
      UIViewController.alloc.initWithNibName(nil, bundle: nil)
    end

  end
end
