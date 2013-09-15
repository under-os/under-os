#
# Generic Point/Size unit
#
class Point
  def ==(point)
    x == point.x && y == point.y
  end
end
