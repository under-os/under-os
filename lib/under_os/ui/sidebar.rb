class UnderOs::UI::Sidebar < UnderOs::UI::View
  wraps UIView, tag: :sidebar

  LOCATIONS = [:top, :left, :right, :bottom]

  def initialize(options={})
    super

    self.location = options.delete(:location) if options.has_key?(:location)
  end

  def location
    @location || :bottom
  end

  def location=(value)
    @location = value.to_sym
    @location = nil if ! LOCATIONS.include?(@location)
  end

  def show
    class_names = self.classNames
    class_names.reject!{ |n| LOCATIONS.include?(n.to_sym) }

    self.classNames = class_names + [location, 'visible']
    self.style = {location => -slide_distance, display: :block}

    animate location => 0
  end

  def hide
    @_class_names -= ['visible']

    animate location => -slide_distance
  end

  def visible?
    classNames.include?('visible')
  end

  def slide_distance
    [:top, :bottom].include?(location) ? size.y : size.x
  end

end
