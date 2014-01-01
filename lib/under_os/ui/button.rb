class UnderOS::UI::Button < UnderOS::UI::View
  wraps UIButton, tag: 'button'

  def initialize(options={})
    super

    self.text  = options.delete(:text) || ''
    @_.showsTouchWhenHighlighted = true
    @_.setBackgroundImage(options.delete(:image), forState:UIControlStateNormal) if options[:image]
    @_.sizeToFit
  end

  def text
    @_.currentTitle
  end

  def text=(new_text, state=UIControlStateNormal)
    @_.setTitle new_text, forState:state
    repaint
  end

  def disabled
    ! @_.isEnabled
  end

  alias :disabled? :disabled

  def disabled=(value)
    @_.enabled = ! value
  end

end
