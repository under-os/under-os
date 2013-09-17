class UnderOS::UI::Button < UnderOS::UI::View

  def initialize(options={}, raw_object=UIButton)
    options = {style: {
      color:      :black,
      background: :lightGray,
      borderRadius: 5
    }}.merge(options)

    super(options, raw_object)

    @_.showsTouchWhenHighlighted = true

    self.text  = options.delete(:text) || ''
  end

  def text
    @_.currentTitle
  end

  def text=(new_title, state=UIControlStateNormal)
    @_.setTitle new_title, forState:state
    @_.sizeToFit
  end

end
