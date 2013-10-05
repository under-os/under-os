#
# The view styles handling wrapper
#
# The idea here is to provide a DOM like `style` object,
# which can take similar to DOM properties and translate
# them into iOS equivalents
#
class UnderOs::UI::Style

  attr_reader :view

  def initialize(view)
    @view = view
  end

  def width
    @view.frame.size.width
  end

  def width=(width)
    @view.frame = [[left, top], [convert_size(width, :x), height]]
  end

  def height
    @view.frame.size.height
  end

  def height=(height)
    @view.frame = [[left, top], [width, convert_size(height, :y)]]
  end

  def top
    @view.frame.origin.y
  end

  def top=(top)
    @view.frame = [[left, convert_size(top, :y)], [width, height]]
  end

  def left
    @view.frame.origin.x
  end

  def left=(left)
    @view.frame = [[convert_size(left, :x), top], [width, height]]
  end

  def right
    UnderOs::Screen.size.x - left
  end

  def right=(right)
    @view.frame = [[UnderOs::Screen.size.x - convert_size(right, :x) - width, top], [width, height]]
  end

  def bottom
    UnderOs::Screen.size.y - top
  end

  def bottom=(bottom)
    @view.frame = [[left, UnderOs::Screen.size.y - convert_size(bottom, :y) - height], [width, height]]
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

  def color(state=UIControlStateNormal)
    if @view.is_a?(UIButton)
      @view.titleColorForState(state)
    else
      @view.textColor if @view.respond_to?(:textColor)
    end
  end

  def color=(color, state=UIControlStateNormal)
    if @view.is_a?(UIButton)
      @view.setTitleColor convert_color(color), forState:state
    else
      @view.textColor = convert_color(color) if @view.respond_to?(:textColor)
    end
  end

  def fontFamily
  end

  def fontFamily=(value)
    @view.font = @view.font.fontWithName(value)
  end

  def fontSize
  end

  def fontSize=(value)
    @view.font = @view.font.fontWithSize(value)
  end

  def textAlign
    case @view.textAlignment
      when NSTextAlignmentRight     then 'right'
      when NSTextAlignmentCenter    then 'center'
      when NSTextAlignmentJustified then 'justify'
      else                               'left'
    end
  end

  def textAlign=(value)
    @view.textAlignment = case value.to_s
    when 'right'   then NSTextAlignmentRight
    when 'center'  then NSTextAlignmentCenter
    when 'justify' then NSTextAlignmentJustified
    else                NSTextAlignmentLeft
    end
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

  def convert_color(color)
    UnderOs::Color.new(color).ui
  end

  def convert_size(size, dim)
    if size.is_a?(String)
      if size.ends_with?('%')
        size = size.slice(0, size.size-1).to_f
        parent_size = view.superview.frame.size.send dim == :x ? :width : :height
        size = parent_size / 100.0 * size
      end
    end

    size
  end
end
