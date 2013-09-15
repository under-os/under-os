class UnderOS::UI::Button < UnderOS::UI::View

  def initialize(options={}, raw_object=UIButton)
    super

    options = {} if ! options.is_a?(Hash)

    self.title = options.delete(:title) || ''
    self.style = {
      color:      :black,
      background: :darkGray,
      borderRadius: 5
    }
  end

  def title
    @_.getTitle
  end

  def title=(new_title, state=UIControlStateNormal)
    @_.setTitle new_title, forState:state
    @_.sizeToFit if style.width == 0
  end

end
