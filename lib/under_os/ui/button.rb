class UnderOS::UI::Button < UnderOS::UI::View
  wraps UIButton, tag: 'button'

  def initialize(options={})
    super

    self.text  = options.delete(:text) || ''
    @_.sizeToFit
    @_.showsTouchWhenHighlighted = true
    @_.setBackgroundImage(options.delete(:image), forState:UIControlStateNormal) if options[:image]
  end

  def text
    @_.currentTitle
  end

  def text=(new_text, state=UIControlStateNormal)
    @_.setTitle new_text, forState:state
  end

end
