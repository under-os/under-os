#
# Generic Point/Size unit
#
class Point

  def initialize(x, y=nil)
    if x.is_a?(Point)
      y = x.y if x.y
      x = x.x
    elsif x.is_a?(Hash)
      y = x[:y] || x['y'] || nil
      x = x[:x] || x['x'] || nil
    end

    @x = x
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end

  def ==(point)
    x == point.x && y == point.y
  end
end
