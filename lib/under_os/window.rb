class UnderOs::Window
  def initialize
    @_ = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end
end
