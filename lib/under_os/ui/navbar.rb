class UnderOs::UI::Navbar
  attr_reader :_

  def initialize(ui_navigation_controller)
    @_ = ui_navigation_controller
  end

  def repaint(stylesheet)
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

  def disable_swipes
    @_.interactivePopGestureRecognizer.enabled = false
  end

  def enable_swipes
    @_.interactivePopGestureRecognizer.enabled = true
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
    views = [views] if views.is_a?(Hash)
    @right_buttons = views
    @_.visibleViewController.navigationItem.rightBarButtonItems =
      views.map{|v| to_navigation_item(v)}.flatten.compact.reverse
  end

private

  def to_navigation_item(view)
    view = to_raw_uiview(view)

    if view.is_a?(UIBarButtonItem)
      view
    elsif view.is_a?(UIView)
      UIBarButtonItem.alloc.initWithCustomView(view)
    elsif view.is_a?(Hash)
      view.map do |type, callback|
        if SYSTEM_BUTTONS[type.to_sym]
          UIBarButtonItem.alloc.initWithBarButtonSystemItem SYSTEM_BUTTONS[type.to_sym], target: callback, action: :call
        elsif type.is_a?(UIImage)
          UIBarButtonItem.alloc.initWithImage(type, style: UIBarButtonItemStylePlain, target: callback, action: :call)
        else
          UIBarButtonItem.alloc.initWithTitle(type.to_s, style: UIBarButtonItemStylePlain, target: callback, action: :call)
        end
      end
    end
  end

  def to_raw_uiview(view)
    view = view.to_sym if view.is_a?(String)
    view = {view: Proc.new{}} if view.is_a?(Symbol)

    if view.is_a?(UnderOs::UI::View)
      view.addClass('navbar-item')
      view.repaint(UnderOs::App.history.current_page.stylesheet)
      view = view._
    end

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
