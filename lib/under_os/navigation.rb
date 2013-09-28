class UnderOs::Navigation
  def initialize(window)
    @_      = UINavigationController.alloc
    @window = window
    UnderOs::Page.navigation = self
  end

  def main_page
    @main_page
  end

  def main_page=(page)
    @_.initWithRootViewController(page._)
    @_.navigationBar.hidden    = !@_visible

    @window.rootViewController = @_
    @window.makeKeyAndVisible
  end

  def visible
    !@_.navigationBar.hidden
  end

  def visible=(visible)
    @_visible = visible
    @_.navigationBar.hidden = !visible if @_.navigationBar
  end

  def push(page, animated=true)
    @_.pushViewController(page._, animated: animated)
  end

  def pop
  end
end
