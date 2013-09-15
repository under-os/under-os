class UnderOs::UI::View
  include UnderOs::Events
  include UnderOs::UI::Styles
  include UnderOs::UI::Dimensions
  include UnderOs::UI::Manipulation

  def initialize(options={}, raw_object=UIView)
    @_ = raw_object.is_a?(UIView) ? raw_object :
      raw_object.alloc.initWithFrame([[0, 0], [0, 0]])

    self.style = options.delete(:style) || {}
  end
end
