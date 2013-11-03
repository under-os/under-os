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

  def ==(*args)
    point = Point.new(*args) # normalizing
    x == point.x && y == point.y
  end

  def *(multiplier)
    self.class.new(x: @x * multiplier, y: @y * multiplier)
  end

  def /(divider)
    self.class.new(x: @x / divider.to_f, y: @y / divider.to_f)
  end

  def to_s
    "x=#{x} y=#{y}"
  end

  def inspect
    "#<#{self.class.name}:0x#{__id__.to_s(16)} #{to_s}>"
  end
end
