class UnderOs::UI::Icon < UnderOs::UI::View
  include UnderOs::UI::IconEngine

  wraps  UIButton, tag: 'icon'
  engine :Awesome

  def initialize(options)
    options = {type: options} if ! options.is_a?(Hash)
    options = {style: {color: 'black'}}.merge(options)

    super(options)

    self.type = options.delete(:type) || :bug
    self.size = options.delete(:size) || 20

    @_.sizeToFit
    @_.showsTouchWhenHighlighted = true
  end

  def type
    @type
  end

  def type=(type)
    @type = type
    @_.setTitle self.class.engine.text(type), forState:UIControlStateNormal
  end

  def size(size=nil)
    if size
      self.size = size
      self
    else
      @size
    end
  end

  def size=(size)
    @size = size
    @_.setFont self.class.engine.font(size)
    @_.sizeToFit
  end
end
