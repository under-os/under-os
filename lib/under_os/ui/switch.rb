class UnderOs::UI::Switch < UnderOs::UI::Input
  wraps UISwitch, tag: 'switch'

  def initialize(options={})
    super
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
