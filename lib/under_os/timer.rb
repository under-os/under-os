class UnderOs::Timer
  def initialize(seconds, options={}, &block)
    @block = block

    @_ = NSTimer.scheduledTimerWithTimeInterval seconds,
      target: self, selector: :kick, userInfo: nil,
      repeats: options[:repeat] || false
  end

  def stop
    @_.invalidate
    self
  end

  def kick
    @block.call
  end
end
