#
# This module handles generic ui dimensions and positions of views
#
module UnderOs::UI::Dimensions
  def size
    @size ||= UnderOs::UI::Dimensions::Size.new(self)
  end

  def size=(size)
    self.size.x = size.x
    self.size.y = size.y
  end

  class Size < UnderOs::Point
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
end
