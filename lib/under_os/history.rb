class UnderOs::History
  attr_reader :_, :navbar

  def initialize
    @_      = UINavigationController.alloc
    @navbar = UnderOs::UI::Navbar.new(@_)
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

  def push(page, animated=true)
    if pages.include?(page)
      pop_to(page)
    else
      @_.pushViewController(page._, animated: animated)
    end
  end

  alias :<< :push

  def pop(page=nil, animated=true)
    if page
      @_.popToViewController(page._, animated: animated)
    else
      @_.popViewControllerAnimated(animated)
    end
  end

  def pages
    @_.viewControllers.map{|c| c.wrapper rescue nil }.compact
  end

  def pop_to(page, animated=true)
    pop(page, animated)
  end

  def pop_to_root(animated=true)
    @_.popToRootViewControllerAnimated(animated)
  end
end
