class UnderOS::UI::Button < UnderOS::UI::View
  wraps UIButton, tag: 'button'

  def initialize(options={})
    super

    self.text  = options.delete(:text) || ''
    @_.showsTouchWhenHighlighted = true
    @_.setBackgroundImage(options.delete(:image), forState:UIControlStateNormal) if options[:image]
  end

  def text
    @_.currentTitle
  end

  def text=(new_text, state=UIControlStateNormal)
    @_.setTitle new_text, forState:state
    repaint
  end

  def repaint(*args)
    size_before = [size.x, size.y]

    super.tap do
      @_.sizeToFit
      size.x = size_before[0] if size_before[0] > size.x
      size.y = size_before[1] if size_before[1] > size.y
    end
  end

end
