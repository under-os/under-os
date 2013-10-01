class UnderOs::UI::Icon < UnderOs::UI::View
  include UnderOs::UI::IconEngine

  wraps  UIButton
  engine :Awesome

  def initialize(options)
    options = {type: options} if ! options.is_a?(Hash)
    options = {style: {color: 'black'}}.merge(options)

    super(options)

    self.type = options.delete(:type) || :bug
    self.size = options.delete(:size) || 20

    @_.showsTouchWhenHighlighted = true
  end

  def type
    @type
  end

  def type=(type)
    @type = type
    @_.setTitle self.class.engine.text(type), forState:UIControlStateNormal
    @_.sizeToFit if style.width == 0
  end

  def size
    @size
  end

  def size=(size)
    @size = size
    @_.setFont self.class.engine.font(size)
  end
end
