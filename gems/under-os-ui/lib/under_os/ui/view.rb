class UnderOs::UI::View
  include UnderOs::UI::Wrap
  include UnderOs::UI::Styles
  include UnderOs::UI::Commons
  include UnderOs::UI::Animation
  include UnderOs::UI::Dimensions
  include UnderOs::UI::Traversing
  include UnderOs::UI::Manipulation

  include UnderOs::Event::Listener
  include UnderOs::Event::Gestures::Listener

  wraps UIView, tag: 'view'

  def initialize(options={})
    self.id        = options.delete(:id)    if options.has_key?(:id)
    self.className = options.delete(:class) if options.has_key?(:class)
    self.style     = options.delete(:style) if options.has_key?(:style)
    self.on        = options.delete(:on)    if options.has_key?(:on)
    self.data      = options.delete(:data)  if options.has_key?(:data)
  end

  def inspect
    params = {tag: tagName}
    params[:id]    = id if id
    params[:class] = className unless classNames.empty?
    params = params.map do |key, value|
      "#{key}=\"#{value}\""
    end

    "#<#{self.class.name} #{params.join(" ")}>"
  end
end
