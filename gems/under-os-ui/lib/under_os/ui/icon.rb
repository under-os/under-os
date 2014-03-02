class UnderOs::UI::Icon < UnderOs::UI::View
  include UnderOs::UI::IconEngine

  wraps  UIButton, tag: 'icon'
  engine :Awesome

  def initialize(options)
    options = {type: options} if ! options.is_a?(Hash)

    super(options)

    self.type = options.delete(:type) || :bug
    self.size = options.delete(:size) || 20
    self.disable if options[:disabled]

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

  def disabled
    ! @_.isEnabled
  end

  alias :disabled? :disabled

  def disabled=(value)
    @_.enabled = ! value
  end

  def disable
    self.disabled = true
  end

  def enable
    self.disabled = false
  end
end
