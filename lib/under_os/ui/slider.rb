class UnderOs::UI::Slider < UnderOs::UI::View
  include UnderOs::UI::Editable

  wraps UISlider, tag: 'slider'

  def initialize(options={})
    super

    self.min   = options[:min]   if options[:min]
    self.max   = options[:max]   if options[:max]
    self.value = options[:value] if options[:value]

    @_.continuous = options.delete(:track) || true # track the changes as they go
    @_.addTarget self, action: :fire_change_event, forControlEvents:UIControlEventValueChanged
  end

  def value
    @_.value
  end

  def value=(value)
    @_.value = value.to_f
  end

  def min
    @_.minimumValue
  end

  def min=(value)
    @_.minimumValue = value.to_f
  end

  def max
    @_.maximumValue
  end

  def max=(value)
    @_.maximumValue = value.to_f
  end

private

  def fire_change_event
    if @_prev_value != @_.value
      @_prev_value = @_.value
      emit :change
    end
  end
end
