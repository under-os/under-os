class UnderOs::Event::Touch
  attr_reader :position, :origin

  def initialize(position, origin)
    @position = position
    @origin   = origin
  end

  def pageX
    position.x
  end

  def pageY
    position.y
  end

  def nodeX
    @position.x - @origin.x
  end

  def nodeY
    @position.y - @origin.y
  end

  alias :viewX :nodeX
  alias :viewY :nodeY

  def inspect
    "#<Touch x=#{pageX} y=#{pageY}"
  end
end
