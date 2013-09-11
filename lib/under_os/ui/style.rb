#
# The view styles handling wrapper
#
# The idea here is to provide a DOM like `style` object,
# which can take similar to DOM properties and translate
# them into iOS equivalents
#
class UnderOs::UI::Style

  module Methods
    def style
      @style ||= UnderOs::UI::Style.new(self)
    end

    def style=(hash)
      hash.each{ |key, value| style.__send__("#{key}=", value)}
    end
  end

  def initialize(view)
    @view = view
    @_    = view.instance_variable_get('@_')
  end

  def width
    @_.frame.size.width
  end

  def width=(width)
    @_.frame = [[left, top], [width, height]]
  end

  def height
    @_.frame.size.height
  end

  def height=(height)
    @_.frame = [[left, top], [width, height]]
  end

  def top
    @_.frame.origin.x
  end

  def top=(top)
    @_.frame = [[left, top], [width, height]]
  end

  def left
    @_.frame.origin.y
  end

  def left=(left)
    @_.frame = [[left, top], [width, height]]
  end

  def right
    screen_width - left
  end

  def right=(right)
    @_.frame = [[screen_width - right, top], [width, height]]
  end

  def bottom
    screen_height - top
  end

  def bottom=(bottom)
    @_.frame = [[left, screen_height - bottom], [width, height]]
  end

  def backgroundColor
    if @view.is_a?(UIButton)
      # TODO ....
    else
      @_.backgroundColor
    end
  end

  def backgroundColor=(color, state = UIControlStateNormal)
    if @view.is_a?(UIButton)
      @_.setBackgroundColor convert_color(color), forState:state
    else
      @_.backgroundColor = convert_color(color)
    end
  end

  alias :background  :backgroundColor
  alias :background= :backgroundColor=

  def color

  end

  def color=(color)
    if @view.is_a?(UIButton)
      @_.setTitleColor color, forState:forState
    else
      # TODO em...
    end
  end

  def fontFamily
  end

  def fontFamily=(value)
  end

  def fontSize
  end

  def fontSize=(value)
  end

private

  def screen_width
    # TODO check for the screen orientation
    UIScreen.mainScreen.bounds.size.width
  end

  def screen_height
    # TODO check for the screen orientation
    UIScreen.mainScreen.bounds.size.height
  end

  def convert_color(color)
    color = UIColor.send "#{color}Color" unless color.is_a?(UIColor)
    color
  end
end
