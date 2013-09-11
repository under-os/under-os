class UnderOs::Window
  attr_reader :root_controller

  def initialize
    @_ = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def main_page=(page)
    @main_page = page
    @_.rootViewController = page.instance_variable_get('@_')
    @_.makeKeyAndVisible
  end
end
