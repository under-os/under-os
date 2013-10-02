class UnderOS::UI::Button < UnderOS::UI::View
  wraps UIButton, tag: 'button'

  def initialize(options={})
    options = {style: {
      color:      :black,
      background: :lightGray,
      borderRadius: 5
    }}.merge(options)

    super(options)

    self.text  = options.delete(:text) || ''
    @_.sizeToFit
  end

  def text
    @_.currentTitle
  end

  def text=(new_text, state=UIControlStateNormal)
    @_.setTitle new_text, forState:state
  end

end
