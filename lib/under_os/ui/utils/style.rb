#
# The view styles handling wrapper
#
# The idea here is to provide a DOM like `style` object,
# which can take similar to DOM properties and translate
# them into iOS equivalents
#
class UnderOs::UI::Style

  def initialize(view)
    @view = view
  end

  def width
    @view.frame.size.width
  end

  def width=(width)
    @view.frame = [[left, top], [width, height]]
  end

  def height
    @view.frame.size.height
  end

  def height=(height)
    @view.frame = [[left, top], [width, height]]
  end

  def top
    @view.frame.origin.y
  end

  def top=(top)
    @view.frame = [[left, top], [width, height]]
  end

  def left
    @view.frame.origin.x
  end

  def left=(left)
    @view.frame = [[left, top], [width, height]]
  end

  def right
    screen_width - left
  end

  def right=(right)
    @view.frame = [[screen_width - right - left, top], [width, height]]
  end

  def bottom
    screen_height - top
  end

  def bottom=(bottom)
    @view.frame = [[left, screen_height - bottom - height], [width, height]]
  end

  def opacity
    @view.alpha
  end

  def opacity=(value)
    @view.alpha = value
  end

  def backgroundColor
    @view.backgroundColor
  end

  def backgroundColor=(color, state=UIControlStateNormal)
    if @view.is_a?(UIButton)
      @view.setBackgroundColor convert_color(color), forState:state
    else
      @view.backgroundColor = convert_color(color)
    end
  end

  alias :background  :backgroundColor
  alias :background= :backgroundColor=

  def color
    if @view.is_a?(UIButton)
      @view.getTitleColor
    else
      @view.textColor
    end
  end

  def color=(color, state=UIControlStateNormal)
    if @view.is_a?(UIButton)
      @view.setTitleColor convert_color(color), forState:state
    else
      @view.textColor = convert_color(color)
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

  def borderRadius
    @view.layer.cornerRadius
  end

  def borderRadius=(radius)
    @view.clipsToBounds      = true
    @view.layer.cornerRadius = radius
  end

  def borderColor
    @view.layer.borderColor
  end

  def borderColor=(color)
    @view.layer.borderColor = convert_color(color).CGColor
  end

  def borderWidth
    @view.layer.borderWidth
  end

  def borderWidth=(width)
    @view.layer.borderWidth = width
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
