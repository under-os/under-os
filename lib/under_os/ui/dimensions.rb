#
# This module handles generic ui dimensions and positions of views
#
module UnderOs::UI::Dimensions
  def size(size=nil)
    if size
      self.size = size
      self
    else
      @size ||= UnderOs::UI::Dimensions::Size.new(self)
    end
  end

  def size=(size)
    size = Point.new(size) # cleaning up

    self.size.x = size.x if size.x
    self.size.y = size.y if size.y
  end

  def position(position=nil)
    if position
      self.position = position
    else
      @position ||= UnderOs::UI::Dimensions::Position.new(self)
    end
  end

  def position=(position)
    position = Point.new(position) # cleaning up

    self.position.x = position.x if position.x
    self.position.y = position.y if position.y
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

  class Position < UnderOs::Point
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
end
