#
# The ui-views manipulation functionality
#
module UnderOs::UI::Manipulation

  def insert(view, position=:end)
    if view.is_a?(Array)
      view.each{|v| insert(v, position)}
    else
      if position == :top
        @_.insertSubview(view._, atIndex: 0)
      else
        @_.addSubview(view._)
      end
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

  def insertTo(view, position=nil)
    view.insert(self, position)
    self
  end

  def remove
    @_.removeFromSuperview
    self
  end

  def clear
    children.each(&:remove)
    self
  end
end
