#
# Generic Point/Size unit
#
class UnderOs::Point
  attr_accessor :x, :y

  def initialize(x, y=nil)
    if x.is_a?(UnderOs::Point)
      y = x.y if x.y
      x = x.x
    elsif x.is_a?(Hash)
      y = x[:y] || x['y'] || nil
      x = x[:x] || x['x'] || nil
    end

    @x = x
    @y = y
  end

  def ==(*args)
    point = UnderOs::Point.new(*args) # normalizing
    x == point.x && y == point.y
  end

  def *(multiplier)
    UnderOs::Point.new(x: x * multiplier, y: y * multiplier)
  end

  def /(divider)
    UnderOs::Point.new(x: x / divider.to_f, y: y / divider.to_f)
  end

  def -(point)
    point = point.is_a?(Numeric) ? UnderOs::Point.new(x: point, y: point) : UnderOs::Point.new(point)
    UnderOs::Point.new(x: x - point.x, y: y - point.y)
  end

  def +(point)
    point = point.is_a?(Numeric) ? UnderOs::Point.new(x: point, y: point) : UnderOs::Point.new(point)
    UnderOs::Point.new(x: x + point.x, y: y + point.y)
  end

  def to_s
    "x=#{x} y=#{y}"
  end

  def inspect
    "#<#{self.class.name}:0x#{__id__.to_s(16)} #{to_s}>"
  end
end
