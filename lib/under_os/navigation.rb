class UnderOs::Navigation
  def initialize(window)
    @_      = UINavigationController.alloc
    @window = window
  end

  def main_page
    @main_page
  end

  def main_page=(page)
    @main_page      = page
    page.navigation = self

    @_.initWithRootViewController(page.instance_variable_get('@_'))
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
end
