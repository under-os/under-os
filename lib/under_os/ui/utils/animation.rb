module UnderOs::UI::Animation

  def animate(style, options={}, &block)
    if block_given?
      options = style
      style   = nil
    else
      block   = Proc.new{ self.style = style }
    end

    Animation.new(self, options, &block)

    self
  end

  def highlight(color=:yellow, options={})
    old_color = style.background

    animate({background: color},     {curve: :ease_out}.merge(options))
    animate({background: old_color}, {curve: :ease_in}.merge(options))
  end

  def fade_in(options={})
    animate({opacity: 1}, options)
  end

  def fade_out(options={})
    animate({opacity: 0}, options)
  end

  class Animation
    CURVES = {
      ease_in_out: UIViewAnimationOptionCurveEaseInOut,
          ease_in: UIViewAnimationOptionCurveEaseIn,
         ease_out: UIViewAnimationOptionCurveEaseOut,
           linear: UIViewAnimationOptionCurveLinear
    }.freeze

    FX_QUEUE = {}

    def initialize(view, options, &block)
      @view    = view
      @options = options
      @block   = block

      @options[:schedule] == false ? run : schedule
    end

    def queue
      FX_QUEUE[@view] ||= []
    end

    def schedule
      if queue.empty?
        run
      else
        queue << self
      end
    end

    def run
      @view.emit('animation:start')

      UIView.animateWithDuration duration,
                          delay: delay,
                        options: options,
                     animations: ->{ @block.call },
                     completion: ->(finished){ run_next }
    end

    def duration
      @options[:duration] || 0.25
    end

    def delay
      @options[:delay] || 0.0
    end

    def options
      options = CURVES[@options[:curve]] || @options[:curve] || UIViewAnimationCurveEaseOut
      options = options | UIViewAnimationOptionAutoreverse if @options[:autoreverse]
      options = options | UIViewAnimationOptionRepeat      if @options[:repeat]
      options | UIViewAnimationOptionAllowUserInteraction
    end

    def run_next
      @view.emit('animation:finished')
      @options[:complete].call if @options[:complete]

      if next_fx = queue.shift
        next_fx.run
      end
    end
  end
end
