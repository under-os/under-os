class UnderOs::Timer
  def self.in(duration, options={}, &block)
    duration = Duration.new(duration) if duration.is_a?(Numeric)
    new duration.to_f, options.merge(repeat: false), &block
  end

  def self.every(duration, options={}, &block)
    duration = Duration.new(duration) if duration.is_a?(Numeric)
    new duration.to_f, options.merge(repeat: true), &block
  end

  attr_reader :block, :counter, :interval, :repeats, :_

  def initialize(seconds, options={}, &block)
    @block    = block
    @counter  = options[:repeat].to_i if options[:repeat].is_a?(Numeric)
    @interval = seconds
    @repeats  = options[:repeat] != false

    @_ = NSTimer.scheduledTimerWithTimeInterval @interval,
      target: self, selector: :kick, userInfo: nil, repeats: @repeats
  end

  def stop
    @_.invalidate
    self
  end

  def kick
    @block.call
    stop if @counter && (@counter -= 1) <= 0
  end

  class Duration
    attr_reader :seconds

    def initialize(seconds)
      @seconds = seconds.to_f
    end

    def to_f
      @seconds
    end

    def to_i
      to_f.to_i
    end

    def to_s
      "#{to_f} seconds"
    end

    def ==(duration)
      duration.is_a?(UnderOs::Timer::Duration) && duration.seconds == @seconds
    end

    def later(options={}, &block)
      UnderOs::Timer.in self, options={}, &block
    end

    def repeat(options={}, &block)
      UnderOs::Timer.every self, options={}, &block
    end
  end
end
