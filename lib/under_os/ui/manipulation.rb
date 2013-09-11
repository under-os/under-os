#
# The ui-views manipulation functionality
#
module UnderOs::UI::Manipulation

  def insert(view, position=:end)
    if position == :top
      @_.insertSubview(view.instance_variable_get('@_'), atIndex: 0)
    else
      @_.addSubview(view.instance_variable_get('@_'))
    end

    self
  end

  def append(view)
    insert(view)
  end

  def prepend(view)
    insert(view, :top)
  end

  def insertTo(view, position=nil)
    view.insert(self, position)
    self
  end

  def remove
    @_.removeFromSuperview
    self
  end

end
