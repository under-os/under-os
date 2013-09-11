class UnderOs::UI::View
  include UnderOs::Events
  include UnderOs::UI::Manipulation
  include UnderOs::UI::Style::Methods

  def initialize(raw_view=nil)
    @_ = raw_view || UIView.alloc.initWithFrame([[0, 0], [0, 0]])
  end
end
