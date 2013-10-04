class UnderOs::Application

  def self.start(&block)
    @start_block = block
  end

  def self.new(*args)
    @inst ||= super *args
  end

  def self.current_page
    @inst.current_page
  end

  def self.stylesheet
    @stylesheet ||= begin
      stylesheet = UnderOs::Page::Stylesheet.new
      stylesheet.load('under-os.css')
      stylesheet.load('application.css')
      stylesheet
    end
  end

  def initialize(ios_app, options)
    @_          = ios_app
    @window     = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @navigation = UnderOs::Navigation.new(@window)

    instance_exec self, &self.class.instance_variable_get('@start_block')
  end

  def config
    @config ||= UnderOs::Config.new(self)
  end

  def navigation
    @navigation
  end

  def current_page
    @navigation.current_page
  end

end
