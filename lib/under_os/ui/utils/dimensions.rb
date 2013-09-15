#
# This module handles generic ui dimensions and positions of views
#
module UnderOs::UI::Dimensions
  def size(size=nil)
    if size
      self.size = size
      self
    else
      @size ||= UnderOs::UI::Size.new(self)
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
      self
    else
      @position ||= UnderOs::UI::Position.new(self)
    end
  end

  def position=(position)
    position = Point.new(position) # cleaning up

    self.position.x = position.x if position.x
    self.position.y = position.y if position.y
  end

end
