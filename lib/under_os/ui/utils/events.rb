#
# Special, UI avare events API
#
module UnderOs::UI::Events

  def on(event, &block)
    return event.map{|e,b| self.on(e,&b)}[0] || self if event.is_a?(Hash)

    event, recognizer = find_recognizer_from(event)

    @_.addGestureRecognizer(recognizer.alloc.initWithTarget(self, action: :emit)) if recognizer

    UnderOs::Events::Listeners.add(self, event, block)
  end

  def no(event)
    UnderOs::Events::Listeners.remove(self, event)
  end

  def emit(*event)
    if event.is_a?(UIGestureRecognizer)
      event  = Event.new(self, event)
      params = nil
    else
      event, params = Array(event)
    end

    UnderOs::Events::Listeners.kick(self, event, params || {})
  end

  def on=(hash)
    on hash
  end

private

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
    event = event.to_sym if event.is_a?(String)

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
    attr_reader :target

    def initialize(view, recognizer)
      @target = view
      name, r = view.__send__ :find_recognizer_from, recognizer.class
      super name, {}
    end
  end
end
