class UnderOs::UI::Position < UnderOs::Point
  def initialize(view)
    @view = view
  end

  def x
    @view.style.left
  end

  def x=(position)
    @view.style.left = position
  end

  def y
    @view.style.top
  end

  def y=(position)
    @view.style.top = position
  end
end
