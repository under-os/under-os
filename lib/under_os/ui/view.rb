class UnderOs::UI::View
  include UnderOs::UI::Events
  include UnderOs::UI::Styles
  include UnderOs::UI::Commons
  include UnderOs::UI::Animation
  include UnderOs::UI::Dimensions
  include UnderOs::UI::Traversing
  include UnderOs::UI::Manipulation

  attr_reader :_

  INSTANCES_REGISTRY = {}

  def self.instance_for(raw_view)
    INSTANCES_REGISTRY[raw_view]
  end

  def initialize(options={}, raw_object=UIView)
    @_ = raw_object.is_a?(UIView) ? raw_object :
      raw_object.alloc.initWithFrame([[0, 0], [0, 0]])

    INSTANCES_REGISTRY[@_] = self

    self.id         = options.delete(:id)    if options.has_key?(:id)
    self.class_name = options.delete(:class) if options.has_key?(:class)
    self.style      = options.delete(:style) if options.has_key?(:style)
    self.on         = options.delete(:on)    if options.has_key?(:on)
  end
end
