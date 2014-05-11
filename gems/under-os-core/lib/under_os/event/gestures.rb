#
# The gesture recognizers module for UI related modules
# by default you have it already included in the `UnderOs::UI::View`
#
# Usage:
#
#     class MyClass
#       include UnderOs::Event::Listener
#       include UnderOs::Event::Gestures::Listener
#
#       attr_reader :_ # <- must have and must respond to `addGestureRecognizer`
#
#       def initialize
#         on :tap do |event|
#           puts "Dips on this object!"
#         end
#       end
#     end
#
module UnderOs::Event::Gestures
  extend self

  module Listener
    def on(event, &block)
      event.each { |e,b| on(e, &b) } and return self if event.is_a?(Hash)

      UnderOs::Event::Storage.add(self, event, block)
      UnderOs::Event::Gestures.init(self, event)

      self
    end
  end

  NAMES = {
    tap:    UITapGestureRecognizer,
    pinch:  UIPinchGestureRecognizer,
    rotate: UIRotationGestureRecognizer,
    swipe:  UISwipeGestureRecognizer,
    pan:    UIPanGestureRecognizer,
    press:  UILongPressGestureRecognizer
  }.freeze

  TOUCH_EVENTS = [
    :touchstart, :touchmove, :touchend, :touchcancel
  ].freeze

  def init(object, event)
    event = event.to_sym if event.is_a?(String)

    if NAMES.has_key?(event)
      init_recognizer(event, object)
    elsif TOUCH_EVENTS.include?(event)
      UnderOs::Event::Touch::Handler.add(event, object)
    end
  end

private

  def init_recognizer(event, object)
    receiver   = Receiver.new(event, object)
    recognizer = NAMES[event].alloc.initWithTarget(receiver, action: :call)

    object._.addGestureRecognizer recognizer

    # UIView in some cases doesn't really listen to anything
    object._.userInteractionEnabled = true if object._.is_a?(UIView)
  end

  # native iOS calls receiver from the recognizers
  class Receiver
    def self.new(event, target)
      super(event, target).tap do |instance|
        @references ||= [] # retain the references so they wouldn't get swiped by GC
        @references << instance
      end
    end

    def initialize(event, target)
      @event  = event
      @target = target
    end

    def call(*event)
      @target.emit @event, native: event
    end
  end
end
