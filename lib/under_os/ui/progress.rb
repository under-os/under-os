class UnderOs::UI::Progress < UnderOs::UI::View
  wraps UIProgressView, tag: :progress

  def initialize(options={})
    super

    self.value = options[:value] if options[:value]
  end

  def value
    @_.progress
  end

  def value=(value)
    @_.setProgress value, animated: true
  end
end
