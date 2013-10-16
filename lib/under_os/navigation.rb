class UnderOs::Navigation
  attr_reader :_

  def initialize
    @_ = UINavigationController.alloc
  end

  def root_page
    @_.topViewController.wrapper
  end

  def root_page=(page)
    @_.initWithRootViewController(page._)
  end

  def current_page
    @_.visibleViewController.wrapper
  end

  def hide(animated=true)
    @_.setNavigationBarHidden(true, animated:animated)
  end

  def show(animated=true)
    @_.setNavigationBarHidden(false, animated:animated)
  end

  def hidden
    @_.navigationBarHidden
  end

  def visible
    !hidden
  end

  def push(page, animated=true)
    @current_page = page
    @_.pushViewController(page._, animated: animated)
  end

  alias :<< :push

  def pop(page=nil, animated=true)
    if page
      @_.popViewController(page._, animated: animated)
    else
      @_.popViewControllerAnimated(animated)
    end
  end
end
