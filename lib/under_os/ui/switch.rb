class UnderOs::UI::Switch < UnderOs::UI::View
  include UnderOs::UI::Editable

  wraps UISwitch, tag: 'switch'

  def initialize(options={})
    super

    self.value   = options[:value]   if options[:value]
    self.checked = options[:checked] if options[:checked]
  end

  def value
    @_value
  end

  def value=(value)
    @_value = value # just saving it on the instance
  end

  def checked
    @_.on?
  end

  def checked=(flag)
    @_.setOn flag, animated: true
  end

end
