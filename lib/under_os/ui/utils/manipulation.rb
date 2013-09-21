#
# The ui-views manipulation functionality
#
module UnderOs::UI::Manipulation

  def insert(view, position=:end)
    if position == :top
      @_.insertSubview(view._, atIndex: 0)
    else
      @_.addSubview(view._)
    end

    self
  end

  def append(*views)
    views.each{|v| insert(v)}
    self
  end

  def prepend(*views)
    views.each{|v| insert(v, :top) }
    self
  end

  def insert_to(view, position=nil)
    view.insert(self, position)
    self
  end

  def remove
    @_.removeFromSuperview
    self
  end

end
