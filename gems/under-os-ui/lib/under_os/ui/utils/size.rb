class UnderOs::UI::Size < UnderOs::Point
  def initialize(view)
    @view = view
  end

  def x
    @view.style.width
  end

  def x=(size)
    @view.style.width = size
  end

  def y
    @view.style.height
  end

  def y=(size)
    @view.style.height = size
  end
end
