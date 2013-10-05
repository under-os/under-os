class UnderOs::UI::Sidebar < UnderOs::UI::View
  wraps UIView, tag: :sidebar

  def initialize(options={})
    super

    self.location = options.delete(:location) if options.has_key?(:location)
    self.animated = options.delete(:animated) if options.has_key?(:animated)
  end

  def location
    @location || :bottom
  end

  def location=(value)
    @location = value.to_sym
  end

  def animated
    @animated == nil ? true : @animated
  end

  def animated=(value)
    @animated = value
  end

  def show
    self.style = if [:bottom, :top].include?(location)
      {:width => '100%', :left =>  0, location => -size.y}
    else
      {:height => '100%', :top => 0, location => -size.x}
    end

    if animated
      animate location => 0
    else
      self.style = {location => 0}
    end

    @visible = true
  end

  def hide
    pos = [:top, :bottom].include?(location) ? -size.y : -size.x

    if animated
      animate location => pos
    else
      self.style = {location => pos}
    end

    @visible = false
  end

  def visible?
    @visible
  end

end
