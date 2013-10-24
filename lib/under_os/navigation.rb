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

  def left_button
    @left_button
  end

  def left_button=(view)
    @left_button = view
    @_.visibleViewController.navigationItem.leftBarButtonItem = to_navigation_item(view)
  end

  def right_button
    right_buttons[0]
  end

  def right_button=(view)
    self.right_buttons = [view]
  end

  def right_buttons
    @right_buttons || []
  end

  def right_buttons=(views)
    @right_buttons = views
    @_.visibleViewController.navigationItem.rightBarButtonItems = views.map{|v| to_navigation_item(v)}
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

private

  def to_navigation_item(view)
    view = view.to_sym if view.is_a?(String)
    view = SYSTEM_BUTTONS[view] if SYSTEM_BUTTONS[view]
    view = UIBarButtonItem.alloc.initWithCustomView(view._) if view.is_a?(UnderOs::UI::View)
    view
  end

  SYSTEM_BUTTONS = {
    done:      UIBarButtonSystemItemDone,
    cancel:    UIBarButtonSystemItemCancel,
    edit:      UIBarButtonSystemItemEdit,
    save:      UIBarButtonSystemItemSave,
    add:       UIBarButtonSystemItemAdd,
    space:     UIBarButtonSystemItemFlexibleSpace,
    compose:   UIBarButtonSystemItemCompose,
    reply:     UIBarButtonSystemItemReply,
    action:    UIBarButtonSystemItemAction,
    organize:  UIBarButtonSystemItemOrganize,
    bookmarks: UIBarButtonSystemItemBookmarks,
    search:    UIBarButtonSystemItemSearch,
    refresh:   UIBarButtonSystemItemRefresh,
    camera:    UIBarButtonSystemItemCamera,
    trash:     UIBarButtonSystemItemTrash,
    stop:      UIBarButtonSystemItemStop,
    play:      UIBarButtonSystemItemPlay,
    pause:     UIBarButtonSystemItemPause,
    rewind:    UIBarButtonSystemItemRewind,
    forward:   UIBarButtonSystemItemFastForward,
    undor:     UIBarButtonSystemItemUndo,
    redo:      UIBarButtonSystemItemRedo,
    curl:      UIBarButtonSystemItemPageCurl,
  }
end
