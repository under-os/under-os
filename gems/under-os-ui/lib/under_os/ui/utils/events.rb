#
# Special, UI avare events API
#
module UnderOs::UI::Events

  def on(event, *args, &block)
    return event.map{|e,b| self.on(e,&b)}[0] || self if event.is_a?(Hash)

    @_.userInteractionEnabled = true

    event = add_ui_event_listener(event)

    UnderOs::Events::Listeners.add(self, event, *args, block)
  end

  def off(event)
    UnderOs::Events::Listeners.remove(self, event)
  end

  def emit(*event)
    if event.is_a?(UIGestureRecognizer)
      name, r = find_recognizer_from(event.class)
      event = Event.new(event, self, name)
    else # emits by a name
      event = Event.new(nil, self, *event)
    end

    UnderOs::Events::Listeners.kick(self, event, {})
  end

  def on=(hash)
    on hash
  end

  class TouchListeners
    def self.listeners
      @listeners ||= Hash.new{ |h,k| h[k] = [] }
    end

    def self.add(eventname, view)
      listeners[eventname] << view
    end

    def self.notify(eventname, event)
      listeners[eventname].each do |view|
        if eventname == :touchmove # being nice and throttling the touchmove events
          return if @__working
          @__working = true
        end

        touches = touches_for_view(view, event)

        view.emit(eventname, touches: touches) if touches.size > 0

        @__working = false
      end
    end

    def self.touches_for_view(view, event)
      frame   = view._.frame
      touches = []

      event.allTouches.each do |touch|
        if point = touch_inside_of(frame, touch)
          touches << Touch.new(view, point)
        end
      end

      touches
    end

    def self.touch_inside_of(frame, touch)
      point = touch.locationInView(nil)
      point = nil if point.x < frame.origin.x ||
           point.y < frame.origin.y ||
           point.x > frame.origin.x + frame.size.width ||
           point.y > frame.origin.y + frame.size.height

      point
    end

    class Touch
      attr_reader :view, :position

      def initialize(view, position)
        @view     = view
        @position = position
      end

      def pageX
        position.x
      end

      def pageY
        position.y
      end

      def viewX
        @position.x - view._.frame.origin.x
      end

      def viewY
        @position.y - view._.frame.origin.y
      end

      def inspect
        "#<Touch x=#{pageX} y=#{pageY}"
      end
    end
  end

private

  def add_ui_event_listener(event)
    event = event.to_sym if event.is_a?(String)
    event = try_add_touch_event_listener(event)
    event, recognizer = find_recognizer_from(event)

    @_.addGestureRecognizer(recognizer.alloc.initWithTarget(self, action: :emit)) if recognizer

    event
  end

  TOUCH_EVENTS = [:touchstart, :touchmove, :touchend, :touchcancel]

  def try_add_touch_event_listener(event)
    if TOUCH_EVENTS.include?(event)
      UnderOs::UI::Events::TouchListeners.add(event, self)
    end

    event
  end

  RECOGNIZERS = {
    tap:    UITapGestureRecognizer,
    pinch:  UIPinchGestureRecognizer,
    rotate: UIRotationGestureRecognizer,
    swipe:  UISwipeGestureRecognizer,
    pan:    UIPanGestureRecognizer,
    press:  UILongPressGestureRecognizer
  }

  # tries to figure event name and gesture recognizer
  def find_recognizer_from(event)
    if event.is_a?(Class) && event < UIGestureRecognizer
      recognizer = event

      if recognizer.respond_to?(:event_name)
        event = recognizer.event_name
      else
        RECOGNIZERS.each{ |e,r| event = e if r == recognizer }
      end

    elsif RECOGNIZERS[event]
      recognizer = RECOGNIZERS[event]
    end

    [event, recognizer]
  end

  class Event < UnderOs::Events::Event
    attr_reader :_, :target

    def initialize(original, target, event, params={})
      @_      = original
      @target = target

      super event, params
    end

    def scale
      @_.scale
    end

    def scale=(value)
      @_.scale = value
    end

    def angle
      @_.rotation
    end

    def angle=(value)
      @_.rotation = value
    end

    def translation(view)
      view = view._ if view.is_a?(UnderOs::UI::View)
      @_.translationInView(view)
    end

    def translation=(params)
      point = params[0]; view = params[1]
      view = view._ if view.is_a?(UnderOs::UI::View)
      @_.setTranslation(point, inView:view)
    end

    RECOGNIZER_STATES = {
      UIGestureRecognizerStateBegan     => :began,
      UIGestureRecognizerStateChanged   => :changed,
      UIGestureRecognizerStateEnded     => :ended,
      UIGestureRecognizerStateCancelled => :canceled,
      UIGestureRecognizerStateFailed    => :failed
    }.freeze

    def state
      RECOGNIZER_STATES[@_.state]
    end
  end
end
