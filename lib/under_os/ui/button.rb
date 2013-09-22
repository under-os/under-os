class UnderOS::UI::Button < UnderOS::UI::View
  wraps UIButton

  def initialize(options={})
    options = {style: {
      color:      :black,
      background: :lightGray,
      borderRadius: 5
    }}.merge(options)

    super(options)

    @_.showsTouchWhenHighlighted = true

    self.text  = options.delete(:text) || ''
    @_.sizeToFit
  end

  def text
    @_.currentTitle
  end

  def text=(new_title, state=UIControlStateNormal)
    @_.setTitle new_title, forState:state
  end

end
