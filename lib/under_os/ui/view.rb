class UnderOs::UI::View
  include UnderOs::UI::Events
  include UnderOs::UI::Styles
  include UnderOs::UI::Commons
  include UnderOs::UI::Animation
  include UnderOs::UI::Dimensions
  include UnderOs::UI::Manipulation

  def initialize(options={}, raw_object=UIView)
    @_ = raw_object.is_a?(UIView) ? raw_object :
      raw_object.alloc.initWithFrame([[0, 0], [0, 0]])

    self.id        = options.delete(:id)    if options.has_key?(:id)
    self.className = options.delete(:class) if options.has_key?(:class)
    self.style     = options.delete(:style) if options.has_key?(:style)
    self.on        = options.delete(:on)    if options.has_key?(:on)
  end
end
